{
package App1;
use strict;
use warnings;


use Dancer ':syntax';

get '/' => sub {

	return "Hello from App1";
};


get '/app1' => sub {
	
	return "Route app1 called from App1";
};
get '/app2' => sub {
	
	return "Route app2 called from App1";
};


1;


}
{

package App2;
use strict;
use warnings;


use Dancer ':syntax';

get '/' => sub {

	return "Hello from App2";
};
get '/app1' => sub {
	
	return "Route app1 called from App2";
};
get '/app2' => sub {
	
	return "Route app2 called from App2";
};
1;
}


use Dancer;
use Dancer::Config 'setting';

load_app 'App1', 'App2';
Dancer::Config->load;
use Plack::Builder;
use Plack::App::URLMap;

setting 'apphandler' => "PSGI";



my $app1 = sub {
    my $env = shift;
    my $request = Dancer::Request->new( $env );
    Dancer->dance( $request );
};
my $app2 = sub {

	my $env = shift;
    my $apps = [ Dancer::App->applications ];
    my $test_app = Dancer::App->get('App2');

    my $req= Dancer::Request->new( $env );
    $test_app->new($req);
    #return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello from App2:' . scalar(@$apps) ] ];
};


builder {

	mount "/a1" => builder { $app1; };
	mount "/a2" => builder { $app2; };
	
};


