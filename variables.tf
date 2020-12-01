
variable vpc_id {
  description = "The ID of the requester VPC"
  type        = string
}

variable peer_vpc_id {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection"
  type        = string
}

variable private_subnets {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable public_subnets {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable private_route_tables {
  description = "List of IDs of private route tables to route to the peer VPC CIDR"
  type        = list(string)
  default     = []
}

variable public_route_tables {
  description = "List of IDs of public route tables to route to the peer VPC CIDR"
  type        = list(string)
  default     = []
}

variable peer_route_tables {
  description = "List of IDs of route tables in the peer account to route to the account VPC CIDR"
  type        = list(string)
  default     = []
}

variable peer_tags {
  description = "Map of tags to add to the peer-side of the VPC peering connection"
  type        = map(string)
  default     = {}
}

variable tags {
  description = "Map of tags to add to the requester VPC peering connection"
  type        = map(string)
  default     = {}
}
