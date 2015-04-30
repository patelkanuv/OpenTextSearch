use strict;
use warnings;
use Test::More;


use Catalyst::Test 'OpenTextSearch';
use OpenTextSearch::Controller::Air::Service;

ok( request('/air/service')->is_success, 'Request should succeed' );
done_testing();
