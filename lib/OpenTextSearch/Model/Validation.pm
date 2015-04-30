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

package OpenTextSearch::Model::Validation;

use Moose;
use Data::Dumper;
use namespace::autoclean;
use Data::Structure::Util qw( unbless );
use Data::Validate::IP qw(is_ipv4 is_ipv6);

use lib qw(../../);
use Travel::Error::Message;

extends 'Catalyst::Model';

=head1 NAME

OpenTextSearch::Model::Validation - Catalyst Model

=head1 DESCRIPTION

Catalyst Model for various levels of input validations.

=cut

=head2 validate_inputs

validate_inputs validates user inputs for the null search, valid IP, access control etc.

=cut

sub validate_inputs {
    my($self, $c, $type)   = @_;
    
    $type   = 'WEB' if !$type;
    #Trying to access extra, stop them
    if($self->{ 'ACCESS_TYPE'} ne 'ALL' && $self->{ 'ACCESS_TYPE'} ne $type) {
        $self->push_error($c, 'Invalid usage of application');
        return 0;
    }
    #is there anything to parse?, Ask them to send some string
    if(!$c->req->body_params->{ 'search_text' }) {
        $self->push_error($c, 'No String to parse');
        return 0;
    }
    #Is it a blocked IP range accessing API, stop them
    my $env = $c->request->env;
    my $ip  = $env->{ 'REMOTE_ADDR'};
    
    #blocked IP range check
    if($c->model('DataTransaction')->is_it_blocked_ip($c, $ip)) {
        $self->push_error($c, 'Access denied');
        return 0;
    }
    
    #web users
    if($type eq 'WEB') {
        my $alloted_cnt = $c->model('DataTransaction')->get_alloted_access($c, 'Web Users');
        my $cnt         = $c->model('DataTransaction')->get_access_count_from_db($c, $ip, 'Web Users');
        
        if($cnt > $alloted_cnt) {
            $self->push_error($c, 'You have reached your daily access limit');
            return 0;
        }
    }
    
    return 1;
}

=head2 validate_service_inputs

validate_service_inputs validates for JSON user inputs for the null search, valid IP, access control etc.

=cut

sub validate_service_inputs {
    my($self, $c)   = @_;
    
    #valid IP address
    if(!is_ipv4($c->req->body_params->{ 'ip' })) {
        $self->push_error($c, 'Invalid Ip address');
        return 0;
    }
    
    #Validate client key
    if(!$c->req->body_params->{ 'client_key' }) {
        $self->push_error($c, 'No client key');
        return 0;
    }
    
    my $client_data = $c->model('DataTransaction')->get_client_data($c, $c->req->body_params->{ 'client_key' });
    my $cnt         = $c->model('DataTransaction')->get_alloted_access($c, $client_data->client_name);
    
    #Validate client key against database
    if(!$cnt) {
        $self->push_error($c, 'Invalid client key');
        return 0;
    }
    
    #Validate client access limit
    if($client_data->client_type eq 'Trial') {
        my $use = $c->model('DataTransaction')->get_client_access_count_from_db($c, $client_data->client_name);
        if($use > $cnt) {
            $self->push_error($c, 'You have reached your daily access limit');
            return 0;
        }
    }
    
    return 1;
}

=head2 push_error

push_error will push the User Errors into Formated object of L<Travel::Error::Message>

=cut

sub push_error {
    my($self, $c, $error)   = @_;
    
    my $err_msg = Travel::Error::Message->new();
    
    $c->stash(
        result  => {
            'errors'    => [unbless($err_msg->get_error_message($error))],
            'success'   => 'false',
        }
    );
    
    return;
}

__PACKAGE__->meta->make_immutable;

1;

=head1 LICENSE

This library is private software. You can not redistribute it and/or modify. Its a property of PerlCraft.net

=cut