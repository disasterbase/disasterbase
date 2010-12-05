package Disaster::Session;

use strict;
use warnings;

use Apache;
use Apache::Cookie;
use Apache::Session::File;

######################################################################

{
	package Disaster;
	use vars qw( %Session );
	sub Session { &Disaster::Session::session }
}

######################################################################

sub session {
	unless ( $Disaster::Session{ _session_id } ) {
		establish_session()
	}
	
	if ( ! scalar @_ ) {
		\%Disaster::Session
	} elsif ( scalar @_ == 1 ) {
		if ( ! ref( $_[0] ) ) {
			$Disaster::Session{ $_[0] }
		} else {
			@Disaster::Session{ @{ $_[0] } }
		}
	} else {
		while ( @_ ) {
			$Disaster::Session{ shift } = shift
		}
	}
}

######################################################################

sub establish_session {
	
	my $r = Apache->request();
	
	my %c = Apache::Cookie->fetch;
	my $session_id = exists $c{disaster_session} ? $c{disaster_session}->value : undef;
 
	eval {
		# 2009-03-11 Simon: if the directory doesn't exist, create it.
		my $session_dir = '/tmp/sessions';
		( -e $session_dir ) or mkdir( $session_dir );
	    tie %Disaster::Session, 'Apache::Session::File', $session_id, {
			Directory => $session_dir,
			LockDirectory => $session_dir,
	    };
	};
 	
	if ( $@ and $@ !~ /Object does not exist/ ) {
	    # die $@; # return error
	    die $@; 
		# 2009-03-11 Simon: made this fatal; if session is broken, don't hide it
	}
	
	Apache::Cookie->new( $r,
		name => 'disaster_session',
		value => $Disaster::Session{_session_id},
		path => '/',
		expires => '+1d',
	)->bake;
	
	$r->register_cleanup( \&release_session );
	
	return;
}

sub release_session {
	untie %Disaster::Session;
}

######################################################################

1;

=head1 NAME

Disaster::Session - Set up Apache::Session for Disaster


=head1 SYNOPSIS

Store information for the current visitor in either of these ways:

  Disaster::Session->{ 'keyname' } = 'value';

  Disaster::Session( 'keyname' => 'value' );

Later, perhaps on another page, retreive it in either of these ways:

  $value = Disaster::Session->{ 'keyname' };

  $value = Disaster::Session( 'keyname' );


=head1 REFERENCE

The first time you call Disaster::Session() within a particular request, it calls establish_session, which arranges to have release_session called at the end of the current request.


=cut
