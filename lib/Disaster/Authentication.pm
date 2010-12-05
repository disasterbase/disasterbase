package Disaster::Authentication;

use strict;

use Digest::MD5 qw( md5_hex );

use Disaster::Session;
use Disaster::SQLEngine;

sub session { &Disaster::Session }

######################################################################

sub attempt_authentication {
	my ( $email, $password ) = @_;
	
	if ( ! $email and ! $password ) {
		return "Please enter your email address and password"
	}
	
	my $user = Disaster::SQLEngine->sqldb()->fetch_one( 
		table => 'user', 
		where => { email => $email },
	);
	
    if ( ! $user or $user->{password} ne md5_hex( $password ) ) {
		return "The requested email and password combination could not be found.";
    }

	return $user;
}

sub user_exists {
	my ( $email ) = @_;
	
	my $user = Disaster::SQLEngine->sqldb()->fetch_one( 
		table => 'user', 
		where => { email => $email },
	);
	return 1 if ref($user);
	return 0;
}

sub fetch_user {
	my ( $user_id ) = @_;
	
	my $user = Disaster::SQLEngine->sqldb()->fetch_one( 
		table => 'user', 
		where => { user_id => $user_id },
	);
	return $user;
}

sub i_am_god {
	my $user;
	$user = current_user();
	return 1 if ref($user) && $user->{god};
	return 0;
}

sub process_authentication {
	my ( $email, $password ) = @_;
	my $result = attempt_authentication( $email, $password );
	if ( ! ref $result ) {
		return $result;
	} else {
		my $user = $result;
		my $session = session();
		
		$session->{ "id" } = $user->{user_id};
	
		return $user;
	}
	
}

######################################################################

sub log_out {
	my $session = session();
	$session->{ "id" } = undef;
}

######################################################################

sub current_user_id {
	my $session = session()
	  or return;
	
	$session->{id}
}

#  returns a Person object.

sub current_user {
	my $session = session()
	  or return;
	
	current_user_id()
	  or return;
    
	fetch_user(current_user_id());
}


1;
