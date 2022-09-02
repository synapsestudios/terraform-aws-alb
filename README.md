# Application Load Balancer

This module creates an AWS Application Load Balancer

https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-application-load-balancer.html

### ALB Limitations

https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-limits.html

## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider_aws) (4.28.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_alb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) (resource)
- [aws_kms_key.alb-key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) (resource)
- [aws_s3_bucket.alb-access-logs-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) (resource)
- [aws_s3_bucket_acl.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) (resource)
- [aws_s3_bucket_public_access_block.public-block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) (resource)
- [aws_s3_bucket_server_side_encryption_configuration.alb-log-encryption-config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input_name)

Description: The name to give the load balancer. The name will have the namespace appended

Type: `string`

### <a name="input_namespace"></a> [namespace](#input_namespace)

Description: Determines naming convention of assets. Generally follows DNS naming convention.

Type: `string`

### <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)

Description: A list of subnet IDs to associate with ALB

Type: `list(string)`

### <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)

Description: VPC ID to associate with ALB

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_security_group_ids"></a> [security_group_ids](#input_security_group_ids)

Description: A list of additional security group IDs to allow access to ALB

Type: `list(string)`

Default: `[]`

### <a name="input_tags"></a> [tags](#input_tags)

Description: A mapping of tags to assign to the AWS resources.

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_load_balancer_arn"></a> [load_balancer_arn](#output_load_balancer_arn)

Description: n/a
