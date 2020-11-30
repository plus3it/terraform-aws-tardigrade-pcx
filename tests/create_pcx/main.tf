provider aws {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "random_string" "this" {
  length  = 6
  number  = false
  special = false
  upper   = false
}

module "vpc_pcx_requester" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.15.0"

  providers = {
    aws = aws
  }

  name = "tardigrade-pcx-requester-${random_string.this.result}"
  cidr = "10.0.0.0/16"
}

module "vpc_pcx_requestee" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.15.0"

  providers = {
    aws = aws
  }

  name = "tardigrade-pcx-requestee-${random_string.this.result}"
  cidr = "10.1.0.0/16"
}

module "create_pcx" {
  source = "../../"
  providers = {
    aws      = aws
    aws.peer = aws
  }

  name          = "tardigrade-pcx-${random_string.this.result}"
  vpc_id        = module.vpc_pcx_requester.vpc_id
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = module.vpc_pcx_requestee.vpc_id
}
