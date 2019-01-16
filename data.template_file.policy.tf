data "template_file" "cloudtrail_policy" {
  template = "${file("${path.module}/files/s3_cloudtrail_policy.json")}"

  vars {
    s3_bucket_name = "cloudtail-${data.aws_caller_identity.current.account_id}"
    account_id     = "${data.aws_caller_identity.current.account_id}"
  }
}
