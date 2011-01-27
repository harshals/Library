package DB::Library::Result::AuthorBooks;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/DB::Schema::Result::AuthorBooks/;


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
