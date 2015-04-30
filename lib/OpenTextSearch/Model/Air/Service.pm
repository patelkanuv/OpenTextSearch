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

package OpenTextSearch::Model::Air::Service;
use Moose;
use namespace::autoclean;

use Data::Structure::Util qw( unbless );
    
use lib qw(../../../);
use Travel::Air::Search::Validate;
use Travel::Air::Search::AutoComplete;
use Travel::Air::Search::Tokens::Parser;

extends 'Catalyst::Model';

=head1 NAME

OpenTextSearch::Model::Air::Service - Catalyst Model

=head1 DESCRIPTION

Catalyst Model for serving JSON Service API.

=cut

=head2 parse_search_string

parse_search_string validate inputs supplied by users. Validates User credential and its access limit.
Once validated, this method will initiate parsing and return result in JSON format.

=cut

sub parse_search_string {
    my($self, $c)   = @_;
    
    my $valid   = $c->model('Validation')->validate_inputs($c, "JSON");
    return if !$valid;
    
    my $valid_input = $c->model('Validation')->validate_service_inputs($c);
    return if !$valid_input;
    
    my $tokens  = Travel::Air::Search::Tokens::Parser->new(
                'data_str'  => $c->req->body_params->{ 'search_text' },
                'IP'        => $c->req->body_params->{ 'ip' }
            );

    my $parsed_data = $tokens->parse_input;
    #print STDERR Dumper $tokens->tokens;
    
    my $valid_query = Travel::Air::Search::Validate->new(parsed_data => $tokens);
    my $final_res   = $valid_query->apply_validations;
    
    $c->stash(
        result  => unbless($final_res)
    );
    
    return ;
}

=head2 parse_search_string

autocomplete_search_string will give suggestion for the user inputs to make his city/airport selection easy.

=cut

sub autocomplete_search_string {
    my($self, $c)   = @_;
    
    my $auto    = Travel::Air::Search::AutoComplete->new(
                    word1       => $c->req->body_params->{ 'option1' },
                    word2       => $c->req->body_params->{ 'option2' },
                    search_text => $c->req->body_params->{ 'search_text' }
                );
    my $value   = $auto->get_suggestions;

    my @result;
    my $len = (scalar(@{$value}) > 10 ) ? 10 : scalar(@{$value});
    
    for(my $i = 0; $i < $len; $i++) {
        push(@result, $value->[$i]);
    }
    $c->stash(
        result  => \@result
    );
    
    return;
}

=head2 validate_search_string

validate_search_string will look for parameter existance in the search string. parameters are 
        location    -> airport / city ,
        dates       -> depart/ return date,
        passenger   -> adult/child/infant count,
        trip_details-> RoundTrip/Oneway
        
=cut

sub validate_search_string {
     my($self, $c)   = @_;
    
    my $env     = $c->request->env;
    my $ip      = $env->{ 'REMOTE_ADDR'};
    my $parser  = Travel::Air::Search::Tokens::Parser->new(
                    'data_str'  => $c->req->body_params->{ 'search_text' },
                    'IP'        => $c->req->body_params->{ 'ip' } || $ip
                );
    #parse Inputs
    $parser->parse_input;
    
    my $date    = 1;
    if($parser->depart_date eq 'Default') {
        $date    = 0;
    }
    
    my $airport = 1;
    if(ref($parser->depart_airport) ne 'ARRAY') {
        $airport = 0;
    }
    my $pax_count   = $parser->pax_adult
                    + $parser->pax_child
                    + $parser->pax_infant;
    my $pax = 1;
    
    if($pax_count == 0) {
        $pax = 0;
    }
    
    my $others  = 1;
    if($parser->trip_type eq 'Default') {
        $others = 0;
    }
    
    $c->stash(
        location    => $airport,
        dates       => $date,
        passenger   => $pax,
        trip_details=> $others
    );
    
    return;
}

__PACKAGE__->meta->make_immutable;

1;
=head1 LICENSE

This library is private software. You can not redistribute it and/or modify. Its a property of PerlCraft.net

=cut