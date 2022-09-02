#PLS READ - NEEDS REFINEMENT AND ABSTRACTING

resource "aws_alb" "alb" {
  name                       = "${var.name}-${var.namespace}"
  tags                       = var.tags
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  access_logs {
    bucket  = aws_s3_bucket.alb-access-logs-bucket.bucket
    prefix  = "${var.name}-${var.namespace}-alb"
    enabled = true
  }

}

resource "aws_s3_bucket" "alb-access-logs-bucket" {
  bucket = "${var.name}-${var.namespace}-alb-access-logs"

  tags = {
    Name        = "${var.name}-bucket"
    Environment = "${var.namespace}"
  }
}

resource "aws_s3_bucket_public_access_block" "public-block" {
  bucket = aws_s3_bucket.alb-access-logs-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "alb-key" {
  description         = "${var.name}-${var.namespace}-key"
  enable_key_rotation = true

}

resource "aws_s3_bucket_server_side_encryption_configuration" "alb-log-encryption-config" {
  bucket = aws_s3_bucket.alb-access-logs-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.alb-key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.alb-access-logs-bucket.id
  acl    = "private"
}

output "load_balancer_arn" {
  value = aws_alb.alb.arn
}
