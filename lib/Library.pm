package Library;

use Dancer ':syntax';
use Dancer::Plugin::DBIC;
use Dancer::Plugin::Memcached;
use Data::Dumper;
use Plack::Middleware::Debug::DBIC::QueryLog;


our $VERSION = '0.1';

set serializer => 'JSON';

my $users = { 'bob' => { 'pass' => 'letmein' , schema => 'User1', db_name => 'user1.db', id => 1 , schema_obj => ''} ,
			  'chris' => { 'pass' => 'letmein' , schema => 'User2', db_name => 'user2.db', id => 1 , schema_obj => ''}
			};

my $schema = '';

get '/' => sub {

	#$schema->resultset("Book")->look_for->serialize;
    template 'index';
};

## index method, simply list 

before sub {
		

	if (! session('user') && request->path_info !~ m{^/login}) {
        var requested_path => request->path_info;
        
        request->path_info('/login');


    } elsif (request->path_info !~ m{^/login} ){
        
		$schema->init_debugger(request->env->{+Plack::Middleware::Debug::DBIC::QueryLog::PSGI_KEY});

		if (exists request->params->{model}) {

			my $sources = join(',', $schema->sources);
			my $model = request->params->{'model'};

			unless ( $sources =~ m/$model/) {
				
				debug "model cannot be found";
				request->path_info('/error');
			}
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
	
	if (params->{username}  && params->{password} eq  $users->{params->{username} }->{pass} ) {
        
        session user => params->{username};

		$schema = schema( session('user') );

		$schema->init_debugger(request->env->{+Plack::Middleware::Debug::DBIC::QueryLog::PSGI_KEY});
		
		$schema->user( $users->{ session('user') }->{id} );

		$users->{ session('user') }->{'schema_obj'} = $schema;

        redirect params->{path} || '/';

    } else {
        redirect '/login?failed=1';
    }

};

## get list of all items

get '/api/:model' => sub {

    my $model = request->params->{'model'};
	
	#my $schema = schema('db');
	#my $schema = $users->{ session('user') }->{'schema_obj'};

	return { data => $schema->resultset($model)->recent(10)->serialize , message => "" };
	
};

get '/api/:model/search' => sub {
	

    my $model = request->params->{'model'};
	
	#my $schema = schema('db');
	#my $schema = $users->{ session('user') }->{'schema_obj'};

	return { data => $schema->resultset($model)->look_for(request->params)->serialize }
};

any '/api/:model/custom/:query' => sub {

	my $model = request->params->{'model'};
	
	#my $schema = schema('db');
	#my $schema = $users->{ session('user') }->{'schema_obj'};

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

	#my $schema = schema('db');
	
	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return { data => $row->serialize, message => "" };
	
};

# update single item

post '/api/:model/:id' => sub {
	
	my $model = request->params->{'model'};
	my $id = request->params->{'id'};
	
	#my $schema = schema('db');

	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return ( { data => {}, error => "row not found" }) unless $row;

	$row->save(request->params);
	
	return { data => $row->serialize };
};

# submit a search request

post '/api/:model' => sub {
	
	my $model = request->params->{'model'};
	
	#my $schema = schema('db');

	my $new = $schema->resultset($model)->fetch_new();

	$new->save(request->params);
	
	return { data => $new->serialize , message => "saved successfully"};
};

# create new item
post '/api/:model/new' => sub {
	
	my $model = request->params->{'model'};
	
	#my $schema = schema('db');

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

	#debug Dumper($response);
};


true;
