# terraform-aws-tardigrade-pcx

Terraform module to create a peering connection


<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.peer | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection | `string` | n/a | yes |
| vpc\_id | The ID of the requester VPC | `string` | n/a | yes |
| peer\_route\_tables | List of IDs of route tables in the peer account to route to the account VPC CIDR | `list(string)` | `[]` | no |
| peer\_tags | Map of tags to add to the peer-side of the VPC peering connection | `map(string)` | `{}` | no |
| private\_route\_tables | List of IDs of private route tables to route to the peer VPC CIDR | `list(string)` | `[]` | no |
| private\_subnets | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| public\_route\_tables | List of IDs of public route tables to route to the peer VPC CIDR | `list(string)` | `[]` | no |
| public\_subnets | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| tags | Map of tags to add to the requester VPC peering connection | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_peering\_connection\_id | The ID of the VPC Peering Connection |
| vpc\_peering\_connection\_status | The status of the VPC Peering Connection request |

<!-- END TFDOCS -->
