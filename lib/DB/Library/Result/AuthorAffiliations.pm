package DB::Library::Result::AuthorAffiliations;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/DB::Schema::Result::AuthorAffiliations/;


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
