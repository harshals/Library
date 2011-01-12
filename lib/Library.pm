
package Library;
use Dancer ':syntax';
use Schema;
use Data::Dumper;

our $VERSION = '0.1';

set serializer => 'JSON';

set 'db' => Schema->new()->init_schema("small.db");

get '/' => sub {
    template 'index';
};

## index method, simply list 

before sub {
	my $schema = setting('db');
	debug "current path is " . request->path;
	$schema->user(1);
};

get '/api/:model' => sub {

	my $schema = setting('db');
    my $params = request->params;
	
	debug $schema->sources;

	if (grep(/$params->{'model'}/, $schema->sources  )   ) {
		
		debug "coming here";
		my $rs = $schema->resultset( $params->{'model'} );
		my $list = $rs->recent->serialize;
		return { data => $list };
	}else {
		
		debug "coming here too";
		return( {error => "model cannot be fond" });
	}
	
};

post '/api/:model' => sub {

	my $schema = setting('db');
    my $params = request->params;
	
	if (grep(/$params->{'model'}/, $schema->sources  )   ) {

		my $rs = $schema->resultset( $params->{'model'} );
		my $list = $rs->recent->serialize;
		return { data => $list };
	}else {
		
		send_error("Model cannot be found");
	}
	
};



true;
