# terraform-aws-tardigrade-pcx

Terraform module to create a peering connection

## Testing

Manual testing:

```
# Replace "xxx" with an actual AWS profile, then execute the integration tests.
export AWS_PROFILE=xxx 
make terraform/pytest PYTEST_ARGS="-v --nomock"
```

For automated testing, PYTEST_ARGS is optional and no profile is needed:

```
make mockstack/up
make terraform/pytest PYTEST_ARGS="-v"
make mockstack/clean
```

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_peer_vpc_id"></a> [peer\_vpc\_id](#input\_peer\_vpc\_id) | The ID of the VPC with which you are creating the VPC Peering Connection | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the requester VPC | `string` | n/a | yes |
| <a name="input_peer_tags"></a> [peer\_tags](#input\_peer\_tags) | Map of tags to add to the peer-side of the VPC peering connection | `map(string)` | `{}` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | List of VPC route objects with a target of the peering connection | <pre>list(object({<br/>    # `name` is used as for_each key<br/>    name                        = string<br/>    provider                    = string<br/>    route_table_id              = string<br/>    destination_cidr_block      = string<br/>    destination_ipv6_cidr_block = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to add to the requester VPC peering connection | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_peering_connection_id"></a> [vpc\_peering\_connection\_id](#output\_vpc\_peering\_connection\_id) | The ID of the VPC Peering Connection |
| <a name="output_vpc_peering_connection_status"></a> [vpc\_peering\_connection\_status](#output\_vpc\_peering\_connection\_status) | The status of the VPC Peering Connection request |

<!-- END TFDOCS -->
