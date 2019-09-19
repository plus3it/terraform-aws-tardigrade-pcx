provider "aws" {
}

provider "aws" {
  alias = "peer"
}

data "aws_vpc" "peer" {
  count = var.create_peering_connection ? 1 : 0

  provider = aws.peer

  id = var.peer_vpc_id
}

resource "aws_vpc_peering_connection" "this" {
  count = var.create_peering_connection ? 1 : 0

  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${format("%v", var.name)}-${format("%v", var.vpc_cidr)}<->${format("%v", var.peer_alias)}-${data.aws_vpc.peer[0].cidr_block}"
    },
  )
}

resource "aws_vpc_peering_connection_accepter" "this" {
  count = var.create_peering_connection ? 1 : 0

  provider = aws.peer

  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
  auto_accept               = true

  tags = {
    Name = "${format("%v", var.peer_alias)}-${data.aws_vpc.peer[0].cidr_block}<->${format("%v", var.name)}-${format("%v", var.vpc_cidr)}"
  }
}

resource "aws_route" "public" {
  count = var.create_peering_connection ? length(var.public_route_tables) : 0

  route_table_id            = var.public_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.peer[0].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
}

resource "aws_route" "private" {
  count = var.create_peering_connection ? length(var.private_route_tables) : 0

  route_table_id            = var.private_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.peer[0].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
}

resource "aws_route" "peer" {
  count = var.create_peering_connection ? length(var.peer_route_tables) : 0

  provider = aws.peer

  route_table_id            = var.peer_route_tables[count.index]
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this[0].id

  depends_on = [aws_vpc_peering_connection_accepter.this]
}

