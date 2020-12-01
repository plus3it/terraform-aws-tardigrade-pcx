provider aws {
  alias = "peer"
}

data aws_caller_identity peer {}

data aws_vpc this {
  id = var.vpc_id
}

data aws_vpc peer {
  provider = aws.peer

  id = var.peer_vpc_id
}

resource aws_vpc_peering_connection this {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  tags          = var.tags
}

resource aws_vpc_peering_connection_accepter this {
  provider = aws.peer

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true
  tags                      = var.peer_tags
}

resource aws_route public {
  count = length(var.public_route_tables)

  route_table_id            = var.public_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource aws_route private {
  count = length(var.private_route_tables)

  route_table_id            = var.private_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource aws_route peer {
  count = length(var.peer_route_tables)

  provider = aws.peer

  route_table_id            = var.peer_route_tables[count.index]
  destination_cidr_block    = data.aws_vpc.this.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this.id

  depends_on = [aws_vpc_peering_connection_accepter.this]
}
