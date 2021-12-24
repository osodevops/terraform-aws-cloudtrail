locals {
  inputs = {
    cloudtrail_id          = aws_cloudtrail.cloudtrail.id
    cloudtrail_home_region = aws_cloudtrail.cloudtrail.home_region
    cloudtrail_arn         = aws_cloudtrail.cloudtrail.arn
    cloudtrail_bucket_name = aws_cloudtrail.cloudtrail.s3_bucket_name
  }
}

output "cloudtrail_outputs" {
  value = merge(locals.cloudtrail_outputs.inputs)
}