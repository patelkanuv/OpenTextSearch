package OpenTextSearch::Schema::OpenTextSearchDB::Result::NlpAccessBlock;

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

OpenTextSearch::Schema::OpenTextSearchDB::Result::NlpAccessBlock

=cut

__PACKAGE__->table("nlp_access_block");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nlp_access_block_id_seq'

=head2 ip_start

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 ip_end

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 ip_start_decimal

  data_type: 'bigint'
  is_nullable: 0

=head2 ip_end_decimal

  data_type: 'bigint'
  is_nullable: 0

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nlp_access_block_id_seq",
  },
  "ip_start",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "ip_end",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "ip_start_decimal",
  { data_type => "bigint", is_nullable => 0 },
  "ip_end_decimal",
  { data_type => "bigint", is_nullable => 0 },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-20 20:13:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MMRlh4J0+Ffd3/7mim8nKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
