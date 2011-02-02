package App2;

use Data::Dumper;
use Plack::Middleware::Debug::DBIC::QueryLog;
use JSON::XS qw/encode_json/;


## index method, simply list 
use Moo;
extends qw/App/;

use Web::Simple __PACKAGE__;


before 'dispatch_request' => sub  {

	my $self = shift;
	
	print STDERR "in App2\n";
	sub (GET + /special) {
	#[ 200, [ 'Content-type', 'text/html' ], [ "Welcome to Deimos Lite" ], ];
		$self->render_html("from 2bd Aoo");
 	 },
 	 sub (GET + /json) {

		 print STDERR "in App2 JSON\n";
		$self->render_json("My 2nd JSON" . $self->title);
	 },
	 sub (GET) {
		
		 print STDERR "not matched anything\n";
		$self->render_html;
	 }
};
1;

=pod

set serializer => 'JSON';

sub authenticate {

	my $app_id = shift;
	debug "Authenticate $app_id :" . request->path_info ;
	
	if (request->path_info !~ m{^/(login|init)}) {
		
		if (!session('user_id') || session('app_id') ne $app_id) {

			flash requested_path => request->path_info;
			request->path_info('/login');

		} else {

			## check to connect to right schema 

			my $schema = my_schema;       

			$schema->init_debugger(request->env->{+Plack::Middleware::Debug::DBIC::QueryLog::PSGI_KEY});

			if (exists request->params->{model}) {

				my $sources = join(',', $schema->sources);
				my $model = request->params->{'model'};

				unless ( $sources =~ m/$model/) {

					send_error("model [ $model ] cannot be found");
				}
			}

		}

	}else {

		## do something if login or logout is accessed

	}

}

before sub {
	
	debug "coming in main before";	
	my $app_id = request->params->{'app_id'};

	send_error("Application ID cannot be found") unless $app_id;	

	&authenticate($app_id);
	
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

=cut
