data "null_data_source" "cloudtrail_outputs" {
  inputs {
    cloudtrail_id = "${aws_cloudtrail.cloudtrail.id}"
    cloudtrail_home_region = "${aws_cloudtrail.cloudtrail.home_region}"
    cloudtrail_arn = "${aws_cloudtrail.cloudtrail.arn}"
    cloudtrail_bucket_arn = "${aws_s3_bucket.cloudtrail_bucket.arn}"
  }
}

output "cloudtrail_outputs" {
  value = "${merge(
        data.null_data_source.cloudtrail_outputs.inputs
    )}"
}