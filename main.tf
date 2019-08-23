provider "aws" {}

provider "aws" {
  alias = "peer"
}

data "aws_vpc" "peer" {
  count = "${var.create_peering_connection ? 1 : 0}"

  provider = "aws.peer"

  id = "${var.peer_vpc_id}"
}

resource "aws_vpc_peering_connection" "this" {
  count = "${var.create_peering_connection ? 1 : 0}"

  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.vpc_id}"
  tags          = "${merge(var.tags, map("Name", "${var.name}-${var.vpc_cidr}<->${var.peer_alias}-${data.aws_vpc.peer.cidr_block}"))}"
}

resource "aws_vpc_peering_connection_accepter" "this" {
  count = "${var.create_peering_connection ? 1 : 0}"

  provider = "aws.peer"

  vpc_peering_connection_id = "${aws_vpc_peering_connection.this.id}"
  auto_accept               = true

  tags {
    Name = "${var.peer_alias}-${data.aws_vpc.peer.cidr_block}<->${var.name}-${var.vpc_cidr}"
  }
}

resource "aws_route" "public" {
  // Must pin count to avoid error "value of 'count' cannot be computed"
  // See:
  //   * <https://docs.cloudposse.com/troubleshooting/terraform-value-of-count-cannot-be-computed/>
  //   * <https://github.com/hashicorp/terraform/issues/12570>
  // Proper value once #12570 has some reasonable resolution:
  //   count = "${var.create_peering_connection ? length(var.public_route_tables) : 0}"
  count = "${var.create_peering_connection ? 1 : 0}"

  route_table_id            = "${var.public_route_tables[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.peer.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this.id}"
}

resource "aws_route" "private" {
  // Must pin count to avoid error "value of 'count' cannot be computed"
  // See:
  //   * <https://docs.cloudposse.com/troubleshooting/terraform-value-of-count-cannot-be-computed/>
  //   * <https://github.com/hashicorp/terraform/issues/12570>
  // Proper value once #12570 has some reasonable resolution:
  //   count = "${var.create_peering_connection ? length(var.private_route_tables) : 0}"
  count = "${var.create_peering_connection ? 1 : 0}"

  route_table_id            = "${var.private_route_tables[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.peer.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this.id}"
}

resource "aws_route" "peer" {
  // No need to pin this one, since we pass this value in
  // I.e. We are not _creating_ the route tables in the same state...
  count = "${var.create_peering_connection ? length(var.peer_route_tables) : 0}"

  provider = "aws.peer"

  route_table_id            = "${var.peer_route_tables[count.index]}"
  destination_cidr_block    = "${var.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.this.id}"

  depends_on = ["aws_vpc_peering_connection_accepter.this"]
}
