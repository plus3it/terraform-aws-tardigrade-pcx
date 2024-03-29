data "aws_caller_identity" "peer" {
  provider = aws.peer
}

resource "aws_vpc_peering_connection" "this" {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  tags          = var.tags
}

resource "aws_vpc_peering_connection_accepter" "this" {
  provider = aws.peer

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true
  tags                      = var.peer_tags
}

resource "aws_route" "this" {
  for_each = { for route in var.routes : route.name => route if route.provider == "aws" }

  route_table_id              = each.value.route_table_id
  destination_cidr_block      = each.value.destination_cidr_block
  destination_ipv6_cidr_block = each.value.destination_ipv6_cidr_block
  vpc_peering_connection_id   = aws_vpc_peering_connection.this.id
}

resource "aws_route" "peer" {
  for_each = { for route in var.routes : route.name => route if route.provider == "aws.peer" }

  provider = aws.peer

  route_table_id              = each.value.route_table_id
  destination_cidr_block      = each.value.destination_cidr_block
  destination_ipv6_cidr_block = each.value.destination_ipv6_cidr_block
  vpc_peering_connection_id   = aws_vpc_peering_connection_accepter.this.id
}
