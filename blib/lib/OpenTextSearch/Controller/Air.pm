package OpenTextSearch::Controller::Air;
use Moose;
use Data::Dumper;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

use Travel::Search::Tokens::Parser;
use Travel::Air::Search::Validate;

=head1 NAME

OpenTextSearch::Controller::Air - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub search :Local {
    my ( $self, $c ) = @_;

    #my $token1  = Travel::Search::Tokens::Parser->new(
    #            data_str    => $c->req->body_params->{ 'search_text' },
    #            'IP'        => '113.20.16.231'
    #        );
    #print STDERR Dumper $token1;
    #my $first   = $token1->parse_input;
    #my $res     = Travel::Air::Search::Validate->new(   parsed_data => $token1);
    #print STDERR Dumper $res->apply_validations;
    
    $c->stash(
        search_text => $c->req->body_params->{ 'search_text' },   
        template    => 'result.tt2',
    );
}

=head1 AUTHOR

kanu,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
