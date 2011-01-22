package User1::Result::AuthorBooks;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Result::AuthorBooks/;


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
