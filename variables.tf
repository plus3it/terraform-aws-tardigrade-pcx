
variable "name" {
  description = "Name of the account; used to construct PCX Name tag"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The ID of the requester VPC. Required when `create_peering_connection` is `true`"
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "CIDR for the VPC. Required when `create_peering_connection` is `true`"
  type        = string
  default     = null
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_route_tables" {
  description = "List of IDs of private route tables to route to the peer VPC CIDR"
  type        = list(string)
  default     = []
}

variable "public_route_tables" {
  description = "List of IDs of public route tables to route to the peer VPC CIDR"
  type        = list(string)
  default     = []
}

variable "peer_owner_id" {
  description = "The AWS account ID of the owner of the peer VPC. Required when `create_peering_connection` is `true`"
  type        = string
  default     = null
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection. Required when `create_peering_connection` is `true`"
  type        = string
  default     = null
}

variable "peer_alias" {
  description = "Alias of the peer account; used to construct PCX Name tag"
  type        = string
  default     = null
}

variable "peer_route_tables" {
  description = "List of IDs of route tables in the peer account to route to the account VPC CIDR"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to the VPC peering connection"
  type        = map(string)
  default     = {}
}
