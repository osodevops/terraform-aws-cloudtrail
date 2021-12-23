
resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.account_name}-all-events"
  s3_bucket_name                = "cloudtail-${data.aws_caller_identity.current.account_id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true

  # CloudTrail trails should have CloudWatch log integration enabled

  cloud_watch_logs_role_arn  = aws_iam_role.cloud_trail.arn
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.log_group.arn}:*"

  depends_on = [module.cloudtrail_bucket]
}

resource "aws_iam_role" "cloud_trail" {
  name = "cloudTrail-cloudWatch-role"

  assume_role_policy = file("${path.module}/files/cloud_trail_assume_role.json")
}

resource "aws_iam_role_policy" "aws_iam_role_policy_cloudTrail_cloudWatch" {
  name = "cloudTrail-cloudWatch-policy"
  role = aws_iam_role.cloud_trail.id

  policy = file("${path.module}/files/aws_iam_role_policy_cloudTrail_cloudWatch.json")
}