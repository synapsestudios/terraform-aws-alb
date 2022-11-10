resource "aws_alb" "alb" {
  name                       = var.name
  tags                       = var.tags
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    prefix  = "${var.name}-alb"
    enabled = true
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

resource "aws_kms_key" "alb_key" {
  description         = "${var.name}-alb-key"
  enable_key_rotation = true

}

resource "aws_s3_bucket_server_side_encryption_configuration" "alb_log_encryption_config" {
  bucket = aws_s3_bucket.alb_access_logs.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.alb_key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.alb_access_logs.id
  acl    = "private"
}

output "load_balancer_arn" {
  value = aws_alb.alb.arn
}
