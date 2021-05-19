# terraform-aws-tardigrade-pcx

Terraform module to create a peering connection


<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_aws.peer"></a> [aws.peer](#provider\_aws.peer) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_vpc.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_peer_vpc_id"></a> [peer\_vpc\_id](#input\_peer\_vpc\_id) | The ID of the VPC with which you are creating the VPC Peering Connection | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the requester VPC | `string` | n/a | yes |
| <a name="input_peer_route_tables"></a> [peer\_route\_tables](#input\_peer\_route\_tables) | List of IDs of route tables in the peer account to route to the account VPC CIDR | `list(string)` | `[]` | no |
| <a name="input_peer_tags"></a> [peer\_tags](#input\_peer\_tags) | Map of tags to add to the peer-side of the VPC peering connection | `map(string)` | `{}` | no |
| <a name="input_private_route_tables"></a> [private\_route\_tables](#input\_private\_route\_tables) | List of IDs of private route tables to route to the peer VPC CIDR | `list(string)` | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_public_route_tables"></a> [public\_route\_tables](#input\_public\_route\_tables) | List of IDs of public route tables to route to the peer VPC CIDR | `list(string)` | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to add to the requester VPC peering connection | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_peering_connection_id"></a> [vpc\_peering\_connection\_id](#output\_vpc\_peering\_connection\_id) | The ID of the VPC Peering Connection |
| <a name="output_vpc_peering_connection_status"></a> [vpc\_peering\_connection\_status](#output\_vpc\_peering\_connection\_status) | The status of the VPC Peering Connection request |

<!-- END TFDOCS -->
