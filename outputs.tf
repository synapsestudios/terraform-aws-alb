output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_alb.this.arn
}

output "primary_listener_arn" {
  description = "ARN of the listener to attach listener rules to"
  value       = var.certificate_arn != "" ? aws_lb_listener.https[0].arn : aws_lb_listener.http[0].arn
}