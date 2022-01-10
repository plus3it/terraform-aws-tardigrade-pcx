module "generated_route_tables" {
  source = "../../"

  providers = {
    aws      = aws
    aws.peer = aws
  }

  vpc_id               = module.vpc_pcx_requester.vpc_id
  peer_vpc_id          = module.vpc_pcx_accepter.vpc_id
  public_route_tables  = module.vpc_pcx_requester.public_route_table_ids
  private_route_tables = module.vpc_pcx_requester.private_route_table_ids

  tags = {
    Name = "tardigrade-pcx-${random_string.this.result}"
  }

  peer_tags = {
    Name = "tardigrade-pcx-${random_string.this.result}"
  }
}

module "vpc_pcx_requester" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.11.0"

  name            = "tardigrade-pcx-requester-${random_string.this.result}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "vpc_pcx_accepter" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.11.1"

  name = "tardigrade-pcx-vpc_pcx_accepter-${random_string.this.result}"
  cidr = "10.1.0.0/16"
}

resource "random_string" "this" {
  length  = 6
  number  = false
  special = false
  upper   = false
}
