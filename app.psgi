use Dancer::Request;

use Plack::Builder;
use Plack::App::URLMap;

use App1;
use App2;

my $app1 = sub {
    my $env = shift;
    
    #return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'yo yo from App1:' . $app->name ] ];
    #return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'yo yo from App1:' . $apps->[1]->name ] ];

    my $request = Dancer::Request->new( $env );
    App1->dance( $request );
};
my $app2 = sub {

	my $env = shift;
    
    #return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'yo yo from App2:' . $apps->[0]->name ] ];

    my $req= Dancer::Request->new( $env );
    App2->dance( $req);
};


my $urlmap = Plack::App::URLMap->new;
$urlmap->map("http://library.com/" => $app1);
$urlmap->map("http://einvoices.com/" => $app2);

my $app = $urlmap->to_app;
