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
| create\_peering\_connection | Controls whether to create the VPC Peering Connection | `bool` | `true` | no |
| name | Name of the account; used to construct PCX Name tag | `string` | `null` | no |
| peer\_alias | Alias of the peer account; used to construct PCX Name tag | `string` | `null` | no |
| peer\_owner\_id | The AWS account ID of the owner of the peer VPC. Required when `create_peering_connection` is `true` | `string` | `null` | no |
| peer\_route\_tables | List of IDs of route tables in the peer account to route to the account VPC CIDR | `list(string)` | `[]` | no |
| peer\_vpc\_id | The ID of the VPC with which you are creating the VPC Peering Connection. Required when `create_peering_connection` is `true` | `string` | `null` | no |
| private\_route\_tables | List of IDs of private route tables to route to the peer VPC CIDR | `list(string)` | `[]` | no |
| private\_subnets | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| public\_route\_tables | List of IDs of public route tables to route to the peer VPC CIDR | `list(string)` | `[]` | no |
| public\_subnets | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| tags | A map of tags to add to the VPC peering connection | `map(string)` | `{}` | no |
| vpc\_cidr | CIDR for the VPC. Required when `create_peering_connection` is `true` | `string` | `null` | no |
| vpc\_id | The ID of the requester VPC. Required when `create_peering_connection` is `true` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_peering\_connection\_id | The ID of the VPC Peering Connection |
| vpc\_peering\_connection\_status | The status of the VPC Peering Connection request |

<!-- END TFDOCS -->
