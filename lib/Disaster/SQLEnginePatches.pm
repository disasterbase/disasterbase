package Disaster::SQLEnginePatches;

use DBIx::SQLEngine;

######################################################################

package DBIx::SQLEngine::Driver::Default;

no warnings 'redefine';

sub retrieve_columns {
    my ($self, $sth) = @_;

    my $type_defs = $self->column_type_codes();
    my $names = $sth->{'NAME'};

    my $types = eval { $sth->{'TYPE'} || [] };
    my $type_codes = [ map { 
	my $typeinfo = scalar $self->type_info($_);
	ref($typeinfo) ? scalar $typeinfo->{'DATA_TYPE'} : $typeinfo;
    } @$types ];
    
    my $sizes = eval { $sth->{'PRECISION'} || [] };
    my $nullable = eval { $sth->{'NULLABLE'} || [] };
    
    [ map {
	my $type = $type_defs->{ $type_codes->[$_] || 0 } || $type_codes->[$_] || 'text';

	{
	    'name' => $names->[$_],
	    'type' => $type,
	    'required' => ! $nullable->[$_],
	    ( $type eq 'text' ? ( 'length' => $sizes->[$_] ) : () ),
	}
    } (0 .. $#$names) ]
    }

######################################################################

package DBIx::SQLEngine::Driver::Mysql;

sub _init {
    my $sqldb = shift;
    $sqldb->select_detect_dbms_flavor();
}

######################################################################

package DBIx::SQLEngine::Driver::Mysql;

sub recoverable_query_exceptions {
  'panic: DBI active kids',
  'Lost connection to MySQL server',
  'MySQL server has gone away',
  'no statement executing',
  'fetch without execute',
  "\Qfetch() without execute()",
  'Malformed packet',
}

######################################################################

1;
