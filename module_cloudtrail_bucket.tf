module "cloudtrail_bucket" {
  source                              = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name                      = "cloudtail-${data.aws_caller_identity.current.account_id}"
  s3_bucket_policy                    = data.template_file.cloudtrail_policy.rendered
  s3_bucket_force_destroy             = true
  enable_lifecycle                    = false
  block_public_acls                   = true
  block_public_policy                 = true
  ignore_public_acls                  = true
  restrict_public_buckets             = true
  s3_sse_algorithm                    = "aws:kms"
  common_tags                         = var.common_tags
}

resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.account_name}-all-events"
  s3_bucket_name                = "cloudtail-${data.aws_caller_identity.current.account_id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  # CloudTrail trails should have CloudWatch log integration enabled
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.log_group.arn}:*"

  depends_on = [module.cloudtrail_bucket]
}