
use Plack::App::URLMap;
use Plack::Builder;


use App;
use App2;

my $app1 = App->new();
my $app2 = App2->new();


$app1->title("App 1 Title ");
$app2->title("App 2 Title ");

my $urlmap = Plack::App::URLMap->new;

$urlmap->map("/a1" => $app1->to_psgi_app);
$urlmap->map("/a2" => $app2->to_psgi_app);

my $app = $urlmap->to_app;


