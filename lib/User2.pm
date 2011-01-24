package User2::Res::Affiliate;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::Affiliate/;

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
package User2::Res::Author;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::Author/;

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

package User2::Res::AuthorAffiliations;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::AuthorAffiliations/;


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
package User2::Res::AuthorBooks;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::AuthorBooks/;


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
package User2::Res::AuthorCategories;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::AuthorCategories/;

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
package User2::Res::Book;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::Book/;

__PACKAGE__->add_columns(

		"classification", { data_type => "VARCHAR(11)", is_nullable => 0 },
);



# You can replace this text with custom content, and it will be preserved on regeneration


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
package User2::Res::Category;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Res::Category/;



__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
package User2::ResSet::Book;

use strict;
use warnings;
use Moose;
use namespace::clean -except => 'meta';
use Carp;

extends qw/Schema::ResSet::Book/;

sub crap_by {
	
	my $self = shift;
	my $category = shift;

	return $self;
};


1;

package User2;

use strict;
use warnings;
use Dancer;
use Moose;
use namespace::clean -except => 'meta';
extends 'Schema';


__PACKAGE__->load_namespaces(
        result_namespace => 'Res',
        resultset_namespace => 'ResSet',
        default_resultset_class => '+DBICx::Hybrid::ResSet');




1;

