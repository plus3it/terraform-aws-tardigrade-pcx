
variable "vpc_id" {
  description = "The ID of the requester VPC"
  type        = string
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection"
  type        = string
}

variable "peer_tags" {
  description = "Map of tags to add to the peer-side of the VPC peering connection"
  type        = map(string)
  default     = {}
}

variable "routes" {
  description = "List of VPC route objects with a target of the peering connection"
  type = list(object({
    # `name` is used as for_each key
    name                        = string
    provider                    = string
    route_table_id              = string
    destination_cidr_block      = string
    destination_ipv6_cidr_block = string
  }))
  default = []
  validation {
    condition     = length(setsubtract(var.routes[*].provider, ["aws", "aws.peer"])) == 0
    error_message = "The `provider` attribute for each VPC route must be one of: \"aws\", \"aws.peer\"."
  }
}

variable "tags" {
  description = "Map of tags to add to the requester VPC peering connection"
  type        = map(string)
  default     = {}
}
