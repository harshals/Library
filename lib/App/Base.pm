package App::Base;

use Dancer ':syntax';
use Dancer::Plugin::DBIC;
use Dancer::Plugin::Memcached;
use Data::Dumper;
use Plack::Middleware::Debug::DBIC::QueryLog;


our $VERSION = '0.1';

set serializer => 'JSON';

our $schema;
our $user ;
our $application ;

our $my_schemas;
our $users;


sub my_schema {

	my $name = shift;
	
	debug "from Base: " . ref vars->{'application'};

    return $my_schemas->{$application->id} if $my_schemas->{$application->id};
	
	$name = $application->id;

	## borrow generic options of master db

	die "The generic schema for master db is not configured"
		unless $application->schema_class ;

	my $dbname = $application->db_name;
	
    my @conn_info =  ("dbi:SQLite:dbname=./var/$dbname");
    
    # pckg should be deprecated
    my $schema_class = $application->schema_class;

    if ($schema_class) {
        $schema_class =~ s/-/::/g;
        eval "use $schema_class";
        if ( my $err = $@ ) {
            die "error while loading $schema_class : $err";
        }
        $my_schemas->{$name} = $schema_class->connect(@conn_info)
    }

    return $my_schemas->{$name};
};

## index method, simply list 


true;
