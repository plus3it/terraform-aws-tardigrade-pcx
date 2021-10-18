module "create_pcx" {
  source = "../../"

  providers = {
    aws      = aws
    aws.peer = aws
  }

  vpc_id      = module.vpc_pcx_requester.vpc_id
  peer_vpc_id = module.vpc_pcx_requestee.vpc_id

  tags = {
    Name = "tardigrade-pcx-${random_string.this.result}"
  }

  peer_tags = {
    Name = "tardigrade-pcx-${random_string.this.result}"
  }
}

module "vpc_pcx_requester" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.9.0"

  name = "tardigrade-pcx-requester-${random_string.this.result}"
  cidr = "10.0.0.0/16"
}

module "vpc_pcx_requestee" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v3.10.0"

  name = "tardigrade-pcx-requestee-${random_string.this.result}"
  cidr = "10.1.0.0/16"
}

resource "random_string" "this" {
  length  = 6
  number  = false
  special = false
  upper   = false
}
