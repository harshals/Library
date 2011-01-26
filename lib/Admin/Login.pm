#
#===============================================================================
#
#         FILE:  Login.pm
#
#  DESCRIPTION:  
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Harshal Shah (Hs), <harshal.shah@gmail.com>
#      COMPANY:  MK Software
#      VERSION:  1.0
#      CREATED:  01/26/2011 17:55:14 IST
#     REVISION:  ---
#===============================================================================

package Admin::Login;

use strict;
use warnings;

use Dancer ':syntax';

our $schema;
our $user;


get '/logout' => sub {
	
	$schema = undef;
	session user_id => '';
	template 'login';
};

get '/login' => sub {
		
	template 'login', { path => vars->{requested_path} };
};

post '/login' => sub {
	
	my $master = schema('db');
	

	if ( $user = $master->resultset('User')->authenticate({ request->params })) {
     	
     	debug "my user data " . ref $user;
        session user_id => $user->id;
		
		$schema = my_schema( $user->application->schema_class );

		$schema->init_debugger(request->env->{+Plack::Middleware::Debug::DBIC::QueryLog::PSGI_KEY});
		
		$schema->user( $user->id );

        redirect params->{path} || '/';

    } else {
        redirect '/login?failed=1';
    }

};

1;
