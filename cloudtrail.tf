
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