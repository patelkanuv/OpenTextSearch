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

package OpenTextSearch::Controller::Air::Service;

use Moose;
use Try::Tiny;
use Data::Dumper;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

OpenTextSearch::Controller::Air::Service - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

return the index page for json request

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->stash->{template}   = 'Service/index.tt2';
    
    return ;
}

=head2 search

Search method initiates the parsing of string into logical travel information.    
=cut

sub search :Local {
    my ( $self, $c ) = @_;

    my $id;
    try {
        $id = $c->model('DataTransaction')->add_client_search_stats($c);
    }
    catch{
        print STDERR $_;
    };
    
    try {
        $c->model('Air::Service')->parse_search_string($c);
    }
    catch{
        print STDERR $_;
    };
    
    if($id) {
        $c->model('DataTransaction')->update_access_record($c, $id, $c->stash->{'result'}{ 'success' });
    }
    
    $c->forward( $c->view('Service') );
    
    return ;
}

=head2 autocomplete

autocomplete method generates various suggestions for the user to search Air Fares.

=cut

sub autocomplete :Local {
    my ( $self, $c ) = @_;

    try {
        $c->model('Air::Service')->autocomplete_search_string($c);
    }
    catch {
        print STDERR $_
    };
    
    $c->forward( $c->view('Service') );
    
    return ;
}

=head2 validate

validate will validate the query in terms of parameters like city, travel dates, passenger etc.
If any of this information is missing then flag will be set to 0, the positive value is 1.

=cut

sub validate :Local {
    my ( $self, $c ) = @_;

    try {
        $c->model('Air::Service')->validate_search_string($c);
    }
    catch {
        print STDERR $_;
    };
    $c->forward( $c->view('Service') );
    
    return ;
}

__PACKAGE__->meta->make_immutable;

1;
=head1 LICENSE

This library is private software. You can not redistribute it and/or modify. Its a property of PerlCraft.net

=cut