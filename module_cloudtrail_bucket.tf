module "cloudtrail_bucket" {
  source                  = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name          = "cloudtail-${data.aws_caller_identity.current.account_id}"
  s3_bucket_policy        = data.template_file.cloudtrail_policy.rendered
  s3_bucket_force_destroy = var.s3_bucket_force_destroy
  common_tags             = var.common_tags
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  s3_sse_algorithm        = var.s3_sse_algorithm
}

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.account_name}-all-events"
  s3_bucket_name                = "cloudtail-${data.aws_caller_identity.current.account_id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  depends_on = [module.cloudtrail_bucket]
}

