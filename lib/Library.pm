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

## get list of all items

get '/api/:model' => sub {

    my $model = request->params->{'model'};
	
	my $schema = schema('db');

	return { data => $schema->resultset($model)->recent(10)->serialize , message => "" };
	
};

get '/api/:model/search' => sub {
	

    my $model = request->params->{'model'};
	
	my $schema = schema('db');

	return { data => $schema->resultset($model)->look_for(request->params)->serialize }
};

any '/api/:model/custom/:query' => sub {

	my $model = request->params->{'model'};
	
	my $schema = schema('db');

	my $query = request->params->{'query'};

	if ($schema->resultset($model)->can($query)) {

		return { data => $schema->resultset($model)->$query(request->params)->serialize }
	}else {
		
		send_error("Unkown query > $query ");
	}
	

};

#get single item

get '/api/:model/:id' => sub {

    my $model = request->params->{'model'};
	my $id = request->params->{'id'};

	my $schema = schema('db');
	
	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return { data => $row->serialize, message => "" };
	
};

# update single item

post '/api/:model/:id' => sub {
	
	my $model = request->params->{'model'};
	my $id = request->params->{'id'};
	
	my $schema = schema('db');

	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return ( { data => {}, error => "row not found" }) unless $row;

	$row->save(request->params);
	
	return { data => $row->serialize };
};

# submit a search request

post '/api/:model' => sub {
	
	my $model = request->params->{'model'};
	
	my $schema = schema('db');

	my $new = $schema->resultset($model)->fetch_new();

	$new->save(request->params);
	
	return { data => $new->serialize , message => "saved successfully"};
};

# create new item
post '/api/:model/new' => sub {
	
	my $model = request->params->{'model'};
	
	my $schema = schema('db');

	my $new = $schema->resultset($model)->fetch_new();

	$new->save(request->params);
	
	return { data => $new->serialize , message => "saved successfully"};
};

any 'error' => sub {
	
	my $error = Dancer::Error->new(
       	code    => 501,
       	message => vars->{error}
   	);
   	$error->render;
};

after sub {
	
	my $response = shift;

	debug Dumper($response);
};


true;
