# Application load balancer

This module creates an application load balancer with a standard set of listeners.

https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-application-load-balancer.html

https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html

### ALB Limitations

https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-limits.html

## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider_aws)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_lb.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) (resource)
- [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) (resource)
- [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) (resource)
- [aws_lb_listener_rule.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) (resource)
- [aws_lb_listener_rule.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) (resource)
- [aws_lb_listener_rule.dealer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) (resource)
- [aws_lb_listener_rule.intercom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) (resource)
- [aws_lb_listener_rule.property](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) (resource)
- [aws_lb_listener_rule.tenant](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_admin_portal_target_group_arn"></a> [admin_portal_target_group_arn](#input_admin_portal_target_group_arn)

Description: ARN of the admin portal target group

Type: `string`

### <a name="input_api_target_group_arn"></a> [api_target_group_arn](#input_api_target_group_arn)

Description: ARN of the API target group

Type: `string`

### <a name="input_certificate_arn"></a> [certificate_arn](#input_certificate_arn)

Description: ARN of the ACM certificate for SSL

Type: `string`

### <a name="input_dealer_portal_target_group_arn"></a> [dealer_portal_target_group_arn](#input_dealer_portal_target_group_arn)

Description: ARN of the dealer portal target group

Type: `string`

### <a name="input_intercom_ui_target_group_arn"></a> [intercom_ui_target_group_arn](#input_intercom_ui_target_group_arn)

Description: ARN of the intercom UI target group

Type: `string`

### <a name="input_name"></a> [name](#input_name)

Description: The name to give the load balancer. The name will have the namespace appended

Type: `string`

### <a name="input_namespace"></a> [namespace](#input_namespace)

Description: Determines naming convention of assets. Generally follows DNS naming convention.

Type: `string`

### <a name="input_property_portal_target_group_arn"></a> [property_portal_target_group_arn](#input_property_portal_target_group_arn)

Description: ARN of the property portal target group

Type: `string`

### <a name="input_public_top_level_domain"></a> [public_top_level_domain](#input_public_top_level_domain)

Description: Hostname which subdomain rules will be appended to e.g. uat.gatehawk.app

Type: `string`

### <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)

Description: A list of subnet IDs to associate with ALB

Type: `list(string)`

### <a name="input_tenant_portal_target_group_arn"></a> [tenant_portal_target_group_arn](#input_tenant_portal_target_group_arn)

Description: ARN of the tenant portal target group

Type: `string`

### <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)

Description: VPC ID to associate with ALB

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_health_check_matcher"></a> [health_check_matcher](#input_health_check_matcher)

Description: The HTTP response codes to indicate a healthy check

Type: `string`

Default: `"200-399"`

### <a name="input_health_check_path"></a> [health_check_path](#input_health_check_path)

Description: The destination for the health check request

Type: `string`

Default: `"/"`

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

### <a name="output_listener_arn"></a> [listener_arn](#output_listener_arn)

Description: n/a

### <a name="output_load_balancer_arn"></a> [load_balancer_arn](#output_load_balancer_arn)

Description: n/a
