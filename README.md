# terraform-aws-tardigrade-pcx

Terraform module to create a peering connection

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_peering\_connection | Controls whether to create the VPC Peering Connection | string | `"true"` | no |
| name | Name of the account; used to construct PCX Name tag | string | `""` | no |
| peer\_alias | Alias of the peer account; used to construct PCX Name tag | string | `""` | no |
| peer\_owner\_id | The AWS account ID of the owner of the peer VPC | string | `""` | no |
| peer\_route\_tables | List of IDs of route tables in the peer account to route to the account VPC CIDR | list | `<list>` | no |
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection | string | `""` | no |
| private\_route\_tables | List of IDs of private route tables to route to the peer VPC CIDR | list | `<list>` | no |
| private\_subnets | A list of private subnets inside the VPC | list | `<list>` | no |
| public\_route\_tables | List of IDs of public route tables to route to the peer VPC CIDR | list | `<list>` | no |
| public\_subnets | A list of public subnets inside the VPC | list | `<list>` | no |
| tags | A map of tags to add to the VPC peering connection | map | `<map>` | no |
| vpc\_cidr | CIDR for the VPC | string | `""` | no |
| vpc\_id | The ID of the requester VPC | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_peering\_connection\_id | The ID of the VPC Peering Connection |
| vpc\_peering\_connection\_status | The status of the VPC Peering Connection request |

