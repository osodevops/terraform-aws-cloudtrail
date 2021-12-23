resource "aws_cloudwatch_log_group" "log_group" {
  name = var.aws_cloudwatch_log_group_name
  retention_in_days  = var.aws_cloudwatch_log_group_retention_in_days
  tags = var.common_tags
}