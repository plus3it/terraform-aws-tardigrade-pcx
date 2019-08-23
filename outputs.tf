output "vpc_peering_connection_id" {
  description = "The ID of the VPC Peering Connection"
  value       = "${join("", aws_vpc_peering_connection_accepter.this.*.id)}"
}

output "vpc_peering_connection_status" {
  description = "The status of the VPC Peering Connection request"
  value       = "${join("", aws_vpc_peering_connection_accepter.this.*.accept_status)}"
}
