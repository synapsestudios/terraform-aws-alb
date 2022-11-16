resource "aws_alb" "this" {
  name                       = var.name
  tags                       = var.tags
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    prefix  = local.log_prefix
    enabled = true
  }

}

locals {
  log_prefix = "${var.name}-alb"
}

resource "aws_lb_listener" "https" {
  count             = var.certificate_arn != "" ? 1 : 0
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  certificate_arn   = var.certificate_arn
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      status_code  = "500"
      message_body = "No matching listener rules"
    }
  }
}

resource "aws_lb_listener" "https_redirect" {
  count             = var.certificate_arn != "" ? 1 : 0
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "http" {
  count             = var.certificate_arn != "" ? 0 : 1
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      status_code  = "500"
      message_body = "No matching listener rules"
    }
  }
}

resource "aws_s3_bucket" "alb_access_logs" {
  bucket = "${var.name}-alb-access-logs"

  tags = {
    Name = "${var.name}-alb-access-logs-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.alb_access_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_elb_service_account" "main" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "allow_load_balancer_write" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.alb_access_logs.arn}/${local.log_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
    ]
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "alb_log_encryption_config" {
  bucket = aws_s3_bucket.alb_access_logs.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.alb_access_logs.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "access_logs" {
  bucket = aws_s3_bucket.alb_access_logs.id
  policy = data.aws_iam_policy_document.allow_load_balancer_write.json
}