package User1::Result::Author;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Result::Author/;

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

