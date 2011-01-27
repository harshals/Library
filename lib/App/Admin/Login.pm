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

package App::Admin::Login;

use strict;
use warnings;

use Dancer ':syntax';
use Dancer::Plugin::DBIC;


get '/logout' => sub {
	
	debug "coming here";
	session user_id => '';
	session app_id => '';
	template 'login';
};

get '/login' => sub {
		
	template 'login', { path => vars->{requested_path} };
};

post '/login' => sub {
	
	my $master = schema('db');
	my $user;

	if ( $user = $master->resultset('User')->authenticate({ request->params })) {
     	
     	debug "my user data " . ref $user;

        session user_id => $user->id;

		my $application = $user->application;
		
        session app_id => $application->id;

     			
        redirect params->{path} || '/';

    } else {
        redirect '/login?failed=1';
    }

};

1;
