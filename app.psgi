use Plack::Builder;

use App;

my $app = App->new();

$app->title("My New App");

builder { $app->to_psgi_app };

