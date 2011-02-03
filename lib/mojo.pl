use Mojolicious::Lite;
use Plack::Builder;

get '/welcome' => sub {
    my $self = shift;
    $self->render(text => 'Hello Mojo!');
};

builder {
    enable 'Deflater';
    app->start;
};

