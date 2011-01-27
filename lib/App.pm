package App;

use Dancer ':syntax';
use Dancer::Plugin::DBIC;
use Dancer::Plugin::Memcached;
use Data::Dumper;
use Plack::Middleware::Debug::DBIC::QueryLog;


use App::Plugin::DBIC;

our $VERSION = '0.1';

set serializer => 'JSON';


## index method, simply list 


before sub {
		

	if (! session('user_id') && request->path_info !~ m{^/(login|init)}) {
        var requested_path => request->path_info;
        
        request->path_info('/login');


    } elsif (request->path_info !~ m{^/(login|logout|init)} ){

		## user is logged in
		debug "Before " . request->path_info ;
		## check to connect to right schema 

		my $schema = my_schema;       

		$schema->init_debugger(request->env->{+Plack::Middleware::Debug::DBIC::QueryLog::PSGI_KEY});

		if (exists request->params->{model}) {

			my $sources = join(',', $schema->sources);
			my $model = request->params->{'model'};

			unless ( $sources =~ m/$model/) {
				
				send_error("model cannot be found");
				#request->path_info('/error');
			}
		}
    }

	
};

## get list of all items

get '/api/:model' => sub {

    my $model = request->params->{'model'};
	my $schema = my_schema;

	return { data => $schema->resultset($model)->recent(10)->serialize , message => "" };
	
};

get '/api/:model/search' => sub {
	

    my $model = request->params->{'model'};
	my $schema = my_schema;
	

	return { data => $schema->resultset($model)->look_for(request->params)->serialize }
};

any '/api/:model/custom/:query' => sub {

	my $model = request->params->{'model'};
	my $schema = my_schema;
	
	debug ref $schema->resultset($model) ;
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
	my $schema = my_schema;

	#my $schema = my_schema('db');
	
	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return { data => $row->serialize, message => "" };
	
};

# update single item

post '/api/:model/:id' => sub {
	
	my $model = request->params->{'model'};
	my $id = request->params->{'id'};
	my $schema = my_schema;
	
	#my $schema = my_schema('db');

	my $row = $schema->resultset($model)->fetch(request->params->{id});

	return ( { data => {}, error => "row not found" }) unless $row;

	$row->save(request->params);
	
	return { data => $row->serialize };
};

# submit a search request

post '/api/:model' => sub {
	
	my $model = request->params->{'model'};
	my $schema = my_schema;
	
	#my $schema = my_schema('db');

	my $new = $schema->resultset($model)->fetch_new();

	$new->save(request->params);
	
	return { data => $new->serialize , message => "saved successfully"};
};

# create new item
post '/api/:model/new' => sub {
	
	my $model = request->params->{'model'};
	my $schema = my_schema;
	
	#my $schema = my_schema('db');

	my $new = $schema->resultset($model)->fetch_new();

	$new->save(request->params);
	
	return { data => $new->serialize , message => "saved successfully"};
};

any 'error' => sub {
	
	my $schema = my_schema;
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
