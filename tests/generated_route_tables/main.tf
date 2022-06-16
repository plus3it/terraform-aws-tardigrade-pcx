module "generated_route_tables" {
  source = "../../"

  providers = {
    aws      = aws
    aws.peer = aws
  }

  vpc_id      = module.vpc_pcx_requester.vpc_id
  peer_vpc_id = module.vpc_pcx_accepter.vpc_id
  routes      = concat(local.routes, local.routes_peer)

  tags = {
    Name = "tardigrade-pcx-${random_string.this.result}"
  }

  peer_tags = {
    Name = "tardigrade-pcx-${random_string.this.result}"
  }
}

module "vpc_pcx_requester" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.14.0"

  name            = "tardigrade-pcx-requester-${random_string.this.result}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "vpc_pcx_accepter" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.14.1"

  name            = "tardigrade-pcx-accepter-${random_string.this.result}"
  cidr            = "10.1.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
}

resource "random_string" "this" {
  length  = 6
  number  = false
  special = false
  upper   = false
}

locals {
  routes = [for i, rt in concat(module.vpc_pcx_requester.public_route_table_ids, module.vpc_pcx_requester.private_route_table_ids) :
    {
      name                        = "route-${i}"
      provider                    = "aws"
      route_table_id              = rt
      destination_cidr_block      = "10.1.0.0/16"
      destination_ipv6_cidr_block = null
    }
  ]

  routes_peer = [for i, rt in concat(module.vpc_pcx_accepter.public_route_table_ids, module.vpc_pcx_accepter.private_route_table_ids) :
    {
      name                        = "route-${i}"
      provider                    = "aws.peer"
      route_table_id              = rt
      destination_cidr_block      = "10.0.0.0/16"
      destination_ipv6_cidr_block = null
    }
  ]
}
