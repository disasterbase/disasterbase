package Disaster::SQLEngine;

use strict;
use warnings;

use DBIx::SQLEngine;
use Disaster::SQLEnginePatches;

###

my ( $dbi_dsn, $dbi_user, $dbi_pass );

sub set_connection_params {
    ( $dbi_dsn, $dbi_user, $dbi_pass ) = @_;
}

sub find_connection_params {
    my ( $conf_file ) = @_;
    
    unless ( $conf_file ) {
	    my $userhome = ($ENV{'HOME'} || $ENV{'LOGDIR'} || (getpwuid($>))[7]);
	    my $local_dir = "$userhome/disasterlocal";
	if ((not defined($local_dir)) or (not -d $local_dir)) {
	    Carp::confess( "Can't find local dir for SQL connection params" );
	  }
	$conf_file = "$local_dir/sqlengine.conf";
    }
    
    open( INFH, $conf_file )
	or Carp::confess( "Can't read $conf_file for SQL connection params" );
    
    my @params = map { chomp; $_ } map <INFH>, 1 .. 3;
    set_connection_params( @params );
    
    1;
}

sub get_new_connection {
    $dbi_dsn
	or Carp::confess( "Did not receive connection params" );
    DBIx::SQLEngine->new( $dbi_dsn, $dbi_user, $dbi_pass );
}

###

my $sqldb;

sub sqldb {
    find_connection_params() unless ( $dbi_dsn );
    $sqldb ||= get_new_connection()
    }

1;
