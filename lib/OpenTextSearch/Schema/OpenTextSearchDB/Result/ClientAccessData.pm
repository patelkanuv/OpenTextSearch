package OpenTextSearch::Schema::OpenTextSearchDB::Result::ClientAccessData;

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

OpenTextSearch::Schema::OpenTextSearchDB::Result::ClientAccessData

=cut

__PACKAGE__->table("client_access_data");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'client_access_data_id_seq'

=head2 client_key

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 client_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 client_quota

  data_type: 'bigint'
  default_value: 100
  is_nullable: 0

=head2 active

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 create_date

  data_type: 'date'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "client_access_data_id_seq",
  },
  "client_key",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "client_name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "client_quota",
  { data_type => "bigint", default_value => 100, is_nullable => 0 },
  "client_type",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "active",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "create_date",
  {
    data_type     => "date",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("unique_client_name", ["client_name"]);

=head1 RELATIONS

=head2 nlp_access_stats

Type: has_many

Related object: L<OpenTextSearch::Schema::OpenTextSearchDB::Result::NlpAccessStat>

=cut

__PACKAGE__->has_many(
  "nlp_access_stats",
  "OpenTextSearch::Schema::OpenTextSearchDB::Result::NlpAccessStat",
  { "foreign.client_name" => "self.client_name" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2013-03-21 08:14:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AS3S5718UJ1dfLXpvF0b6g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
