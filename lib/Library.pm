

package Library;

use lib "lib";
use Dancer ':syntax';
use Schema;
use Dancer::Plugin::DBIC;
use Data::Dumper;

our $VERSION = '0.1';

set serializer => 'JSON';

#set 'db' => Schema->new()->init_schema("small.db");

get '/' => sub {
    template 'index';
};

## index method, simply list 

before sub {

	if (! session('user') && request->path_info !~ m{^/login}) {
        var requested_path => request->path_info;
        request->path_info('/login');
    }


	my $schema = schema('Schema');
	
	debug "schema user is " . $schema->user;

	## replace this by logged in user

	#$schema->user(1);
	
	## current path is request->path
};

get '/login' => sub {
		
	session user => 1;
	template 'login', { path => vars->{requested_path} };
};

post '/login' => sub {
	
	if (params->{username} eq 'bob' && params->{password} eq 'letmein') {
         session user => params->{username};
         schema('Schema')->user(session('user'));
         redirect params->{path} || '/';
    } else {
        redirect '/login?failed=1';
    }

};

get '/api/:model' => sub {

	my $schema = schema('Schema');
    my $params = request->params;
	
	if (grep(/$params->{'model'}/, $schema->sources  )   ) {
		
		my $rs = $schema->resultset( $params->{'model'} );
		my $list = $rs->recent->serialize;
		return { user => session('user') , data => $list };
	}else {
		
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
