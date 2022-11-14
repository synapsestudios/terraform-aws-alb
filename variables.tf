variable "name" {
  type        = string
  description = "The name to give the load balancer. The name will have the namespace appended"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the AWS resources."
  default     = {}
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of additional security group IDs to allow access to ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to associate with ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with ALB"
}

variable "certificate_arn" {
  type        = string
  default     = ""
  description = "ARN of the Certificate Manager cert to use for HTTPS connections, automatically creates an HTTPS listener if set"
}