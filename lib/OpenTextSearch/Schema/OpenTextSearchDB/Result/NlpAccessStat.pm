package OpenTextSearch::Schema::OpenTextSearchDB::Result::NlpAccessStat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

OpenTextSearch::Schema::OpenTextSearchDB::Result::NlpAccessStat

=cut

__PACKAGE__->table("nlp_access_stats");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nlp_access_stats_id_seq'

=head2 access_time

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 client_ip

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 request_ip

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 client_name

  data_type: 'varchar'
  default_value: 'General access'
  is_foreign_key: 1
  is_nullable: 1
  size: 100

=head2 request_string

  data_type: 'varchar'
  is_nullable: 0
  size: 500

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nlp_access_stats_id_seq",
  },
  "access_time",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "client_ip",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "request_ip",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "client_name",
  {
    data_type => "varchar",
    default_value => "General access",
    is_foreign_key => 1,
    is_nullable => 1,
    size => 100,
  },
  "request_string",
  { data_type => "varchar", is_nullable => 0, size => 500 },
  "result_status",
  {data_type => "boolean", default_value => \"false", is_nullable => 0}
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 client_name

Type: belongs_to

Related object: L<OpenTextSearch::Schema::OpenTextSearchDB::Result::ClientAccessData>

=cut

__PACKAGE__->belongs_to(
  "client_name",
  "OpenTextSearch::Schema::OpenTextSearchDB::Result::ClientAccessData",
  { client_name => "client_name" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ACvO+QVVim7WnefEPWMHHw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
