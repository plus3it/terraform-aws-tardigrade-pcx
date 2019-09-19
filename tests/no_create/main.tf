provider aws {
  region = "us-east-1"
}

module "no_create" {
  source = "../../"
  providers = {
    aws      = aws
    aws.peer = aws
  }

  create_peering_connection = false
}
