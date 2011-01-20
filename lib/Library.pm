package Library;

use Dancer ':syntax';
use Dancer::Plugin::DBIC;
use Data::Dumper;
use Plack::Middleware::Debug::DBIC::QueryLog;


our $VERSION = '0.1';

set serializer => 'JSON';


get '/' => sub {
    template 'index';
};

## index method, simply list 

before sub {
		
	my $schema = schema('db');
	$schema->init_debugger(request->env->{+Plack::Middleware::Debug::DBIC::QueryLog::PSGI_KEY});

	if (! config->{loggedin} && ! session('user') && request->path_info !~ m{^/login}) {
        var requested_path => request->path_info;
        request->path_info('/login');
    }

	$schema->user(1);
	
	if (exists request->params->{model}) {
		
		my $sources = join(',', $schema->sources);
		my $model = request->params->{'model'};
		
		unless ( $sources =~ m/$model/) {
			
			request->path_info('/error');
		}
	}


};

get '/logout' => sub {
	
	session user => '';
	set 'db' => '';
	template 'login';
};

get '/login' => sub {
		
	template 'login', { path => vars->{requested_path} };
};

post '/login' => sub {
	
	if (params->{username} eq 'bob' && params->{password} eq 'letmein') {
         session user => params->{username};
         redirect params->{path} || '/';
    } else {
        redirect '/login?failed=1';
    }

};

get '/api/:model' => sub {

    my $model = request->params->{'model'};
	
	my $schema = schema('db');

	return { data => $schema->resultset($model)->recent->serialize };
	
};

get '/api/:model/:id' => sub {

    my $model = request->params->{'model'};
	my $id = request->params->{'id'};

	my $schema = schema('db');
	
	my $row = $schema->resultset($model)->fetch(request->params->{id});

	unless ($row) {
		
		var error => "$model with id $id not found";
		redirect '/error';
	}
	
	return { data => $row->serialize, message => "Mission Successfull" };
	
};


post '/api/:model/:id' => sub {
	
	my $model = request->params->{'model'};
	my $id = request->params->{'id'};
	
	my $schema = schema('db');

	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return ( { data => {}, error => "row not found" }) unless $row;

	$row->save(request->params);
	
	return { data => $row->serialize };
};

post '/api/:model' => sub {
	
	my $model = request->params->{'model'};
	
	my $schema = schema('db');

	my $new = $schema->resultset($model)->fetch_new();

	$new->save(request->params);
	
	return { data => $new->serialize };
};

any 'error' => sub {
	

	my $error = Dancer::Error->new(
       	code    => 501,
       	message => vars->{error}
   	);
   	$error->render;
};


true;
