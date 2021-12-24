
resource "aws_iam_role" "cloud_trail" {
  name = "cloudTrail-cloudWatch-role"

  assume_role_policy = data.aws_iam_policy_document.cloud_trail_policy_document.json
}
data "aws_iam_policy_document" "cloud_trail_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "aws_iam_role_policy_cloudTrail_cloudWatch" {
  name = "cloudTrail-cloudWatch-policy"
  role = aws_iam_role.cloud_trail.id

  policy = data.aws_iam_policy_document.aws_iam_role_policy_document.json
}

data "aws_iam_policy_document" "aws_iam_role_policy_document" {
  statement {
    sid    = "AWSCloudTrailCreateLogStream2014110"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
    ]

    resources = [
      "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
    ]
  }
  statement {
    sid    = "AWSCloudTrailPutLogEvents20141101"
    effect = "Allow"

    actions = [
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
    ]
  }
}
