package App::Base;

use Dancer ':syntax';
use Dancer::Plugin::DBIC;
use Dancer::Plugin::Memcached;
use Data::Dumper;
use Plack::Middleware::Debug::DBIC::QueryLog;


our $VERSION = '0.1';

set serializer => 'JSON';

our $my_schemas;
our $users;




## index method, simply list 


true;
