{
package App1;
use strict;
use warnings;


use Dancer ':syntax';
setting 'apphandler' => "PSGI";
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

use Plack::Builder;
use Plack::App::URLMap;


my $app1 = sub {
    my $env = shift;
    my $request = Dancer::Request->new( $env );
    Dancer->dance( $request );
};


my $app3 = sub {

	my $env = shift;
    return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello from PSGI' ] ];
};


builder {

	mount "/a1" => builder { 
		enable 'Session', store => 'File';
		enable 'Debug' ,
			panels => [qw/Memory Response Timer Environment Dancer::Settings Dancer::Logger Parameters Dancer::Version Session DBIC::QueryLog/];
    	enable "ConsoleLogger";
		enable "Plack::Middleware::Static",
          	   path => qr{^/?(images|javascript|css|js)/}, root => './public/';
 	
	$app1; };
	mount "/a2" => builder { $app3; };
	
};



