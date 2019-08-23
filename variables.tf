variable "create_peering_connection" {
  description = "Controls whether to create the VPC Peering Connection"
  default     = true
}

variable "name" {
  description = "Name of the account; used to construct PCX Name tag"
  type        = "string"
  default     = ""
}

variable "vpc_id" {
  description = "The ID of the requester VPC"
  type        = "string"
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = "string"
  default     = ""
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = "list"
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = "list"
  default     = []
}

variable "private_route_tables" {
  description = "List of IDs of private route tables to route to the peer VPC CIDR"
  type        = "list"
  default     = []
}

variable "public_route_tables" {
  description = "List of IDs of public route tables to route to the peer VPC CIDR"
  type        = "list"
  default     = []
}

variable "peer_owner_id" {
  description = "The AWS account ID of the owner of the peer VPC"
  type        = "string"
  default     = ""
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection"
  type        = "string"
  default     = ""
}

variable "peer_alias" {
  description = "Alias of the peer account; used to construct PCX Name tag"
  type        = "string"
  default     = ""
}

variable "peer_route_tables" {
  description = "List of IDs of route tables in the peer account to route to the account VPC CIDR"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to the VPC peering connection"
  type        = "map"
  default     = {}
}
