use strict;
use warnings;
use Test::More;


use Catalyst::Test 'OpenTextSearch';
use OpenTextSearch::Controller::Air;

ok( request('/air')->is_success, 'Request should succeed' );
done_testing();
