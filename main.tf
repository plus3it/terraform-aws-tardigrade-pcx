provider "aws" {
  alias = "peer"
}

data "aws_vpc" "peer" {
  provider = aws.peer

  id = var.peer_vpc_id
}

resource "aws_vpc_peering_connection" "this" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${format("%v", var.name)}-${format("%v", var.vpc_cidr)}<->${format("%v", var.peer_alias)}-${data.aws_vpc.peer.cidr_block}"
    },
  )
}

resource "aws_vpc_peering_connection_accepter" "this" {
  provider = aws.peer

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true

  tags = {
    Name = "${format("%v", var.peer_alias)}-${data.aws_vpc.peer.cidr_block}<->${format("%v", var.name)}-${format("%v", var.vpc_cidr)}"
  }
}

resource "aws_route" "public" {
  count = length(var.public_route_tables)

  route_table_id            = var.public_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "private" {
  count = length(var.private_route_tables)

  route_table_id            = var.private_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "peer" {
  count = length(var.peer_route_tables)

  provider = aws.peer

  route_table_id            = var.peer_route_tables[count.index]
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this.id

  depends_on = [aws_vpc_peering_connection_accepter.this]
}

