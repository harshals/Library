use Dancer;
load_app 'Library';

use Dancer::Config 'setting';
Dancer::Config->load;

use Plack::Builder;
my $app = sub {
    my $env = shift;
    my $request = Dancer::Request->new( $env );
    Dancer->dance( $request );
};

builder {

	mount "/" => builder {
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
		enable "Plack::Middleware::AccessLog",
				format => "%r %s";

    	$app;
	};
	
};


