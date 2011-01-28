use Dancer;
use Plack::App::URLMap;

use Plack::Builder;
#load_app 'Library', 'Einvoices' ;

use Dancer::Config 'setting';
Dancer::Config->load;

my $app1 = sub {
	load_app 'Library';
    my $env = shift;
    my $request = Dancer::Request->new( $env );
    Library->dance( $request );
};

my $app2 = sub {
	load_app 'Einvoices';
    my $env = shift;
    my $request = Dancer::Request->new( $env );
    Einvoices->dance( $request );
};

builder {


	mount "http://library.com/" => builder {
		enable 'Session', store => 'File';
		enable 'Debug' ,
			panels => [qw/Memory Response Timer Environment Dancer::Settings Dancer::Logger Parameters Dancer::Version Session DBIC::QueryLog/];
    	enable "ConsoleLogger";
		enable "Plack::Middleware::Static",
          	   path => qr{^/?(images|javascript|css|js)/}, root => './public/';
 		enable "Plack::Middleware::ServerStatus::Lite",
          	   path => '/status',
          	   allow => [ '127.0.0.1', '192.168.0.0/16' ],
          	   scoreboard => '/tmp';

		$app1;
	},

	mount "http://einvoices.com/" => builder {
		enable 'Session', store => 'File';
		enable 'Debug' ,
			panels => [qw/Memory Response Timer Environment Dancer::Settings Dancer::Logger Parameters Dancer::Version Session DBIC::QueryLog/];
    	enable "ConsoleLogger";
		enable "Plack::Middleware::Static",
          	   path => qr{^/?(images|javascript|css|js)/}, root => './public/';
 		enable "Plack::Middleware::ServerStatus::Lite",
          	   path => '/status',
          	   allow => [ '127.0.0.1', '192.168.0.0/16' ],
          	   scoreboard => '/tmp';

		$app2;
	}

}

