variable "account_name" {
  type        = string
  description = "The name of the account"
}

variable "common_tags" {
  type = map(string)
}

variable "aws_cloudwatch_log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group."
  default = "/aws/cloudtrail/logs"
}

variable "aws_cloudwatch_log_group_retention_in_days" {
  type = number
  description = "The amount of fays to retain the logs for."
  default = 90
}