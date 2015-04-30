use strict;
use warnings;

use OpenTextSearch;

my $app = OpenTextSearch->apply_default_middlewares(OpenTextSearch->psgi_app);
$app;

