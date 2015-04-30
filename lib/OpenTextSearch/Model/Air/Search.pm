######
##
## Copyright (c) PerlCraft.net, 2013
## The contents of this file are the property of PerlCraft.net or its
## associate companies or organizations (the Owners), and constitute
## copyrighted proprietary software and/or information.  This file or the
## information contained therein may not be used except in compliance
## with the terms set forth hereunder.
##
## Reproduction or distribution of this file or of the information
## contained therein in any form or through any mechanism whatsoever,
## whether electronic or otherwise, is prohibited except for lawful use
## within the organization by authorized employees of the Owners
##  for the purpose of software development or operational deployment
## on authorized equipment.  Removal of this file or its contents by any
## means whether electronic or physical save when expressly permitted in
## writing by the Owners or their authorized representatives is prohibited.
##
## Installation or copying of this file or of the code contained therein on
## any equipment excepting that owned or expressly authorized for the purpose
## by the Owners is prohibited.
##
## Any violation of the terms of this licence shall be deemed to be a
## violation of the Owner's intellectual property rights and shall be
## treated as such under the applicable laws and statutes.
##
######

=head1 AUTHOR

Kanu Patel, India
Email : patelkanuv@gmail.com

=cut

package OpenTextSearch::Model::Air::Search;
use Moose;
use Data::Dumper;
use namespace::autoclean;

use lib qw(../../../);
use Travel::Air::Search::Validate;
use Travel::Air::Search::Tokens::Parser;

extends 'Catalyst::Model';

=head1 NAME

OpenTextSearch::Model::Air::Search - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=cut

=head2 parse_search_string

parse_search_string validate inputs supplied by users. Validates User credential and its access limit.
Once validated, this method will initiate parsing and return result in JSON format.

=cut

sub parse_search_string {
    my($self, $c)   = @_;
    
    my $valid   = $c->model('Validation')->validate_inputs($c);
    return if !$valid;
    
    my $env     = $c->request->env;
    my $ip      = $env->{ 'REMOTE_ADDR'};
    
    my $tokens  = Travel::Air::Search::Tokens::Parser->new(
                'data_str'  => $c->req->body_params->{ 'search_text' },
                'IP'        => '113.20.16.231'
            );

    my $parsed_data = $tokens->parse_input;
    #print STDERR Dumper $tokens->tokens;
    
    my $valid_query = Travel::Air::Search::Validate->new(parsed_data => $tokens);
    my $final_res   = $valid_query->apply_validations;
    
    $c->stash(
        result  => $final_res
    );
    
    return ;
}

__PACKAGE__->meta->make_immutable;

1;
=head1 LICENSE

This library is private software. You can not redistribute it and/or modify. Its a property of PerlCraft.net

=cut
