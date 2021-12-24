module "cloudtrail_bucket" {
  source                              = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name                      = "cloudtail-${data.aws_caller_identity.current.account_id}"
  s3_bucket_policy                    = data.aws_iam_policy_document.s3_bucket_policy.json
  s3_bucket_force_destroy             = true
  enable_lifecycle                    = false
  block_public_acls                   = true
  block_public_policy                 = true
  ignore_public_acls                  = true
  restrict_public_buckets             = true
  s3_sse_algorithm                    = "aws:kms"
  common_tags                         = var.common_tags
}
data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    actions = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3::cloudtail-${data.aws_caller_identity.current.account_id}"]
  }
  statement {
    sid = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3::cloudtail-${data.aws_caller_identity.current.account_id}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test = "StringEquals"
      variable = "s3:x-amz-acl"
      values = ["bucket-owner-full-control"]
    }
  }
}