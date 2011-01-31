

use Plack::Builder;
use Plack::App::URLMap;
use Dancer::App;

my $app2 = sub {
    use Dancer ':setting';

    setting port       => 3001;
    setting apphandler => 'PSGI';
    setting access_log => 0;
	
	my $app_name = Dancer::App->current();

    get '/' => sub { return "Hello from App2 " };

    return [ 200, [], [ "Hello from Einvoices " . $app_name->name ] ];
    my $env     = shift;
    my $request = Dancer::Request->new($env);
    Dancer->dance($request);
};


my $app1 = sub {
    use Dancer ':setting';

    setting port       => 3002;
    setting apphandler => 'PSGI';
    setting access_log => 0;
    setting name => 'Library';

	my $app_name = Dancer::App->current();

    get '/' => sub { return "Hello from Dancer App1 :" };

    #return [ 200, [], [ "Hello from LIbrary " . $app_name->name ] ];
    my $env     = shift;
    my $request = Dancer::Request->new($env);
    $app_name->dance($request);
};

my $app3 = sub {
    return [ 200, [], [ "Hello from App1" ] ];
};

my $app4 = sub {
    
    my $env     = shift;
    return [ 200, [], [ "Hello from App2" ] ];
};

 my $urlmap = Plack::App::URLMap->new;
  $urlmap->map("http://library.com/" => $app1);
  $urlmap->map("http://einvoices.com/" => $app2);

  my $app = $urlmap->to_app;



