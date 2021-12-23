
resource "aws_iam_role" "cloud_trail" {
  name = "cloudTrail-cloudWatch-role"

  assume_role_policy = file("${path.module}/files/cloud_trail_assume_role.json")
}

resource "aws_iam_role_policy" "aws_iam_role_policy_cloudTrail_cloudWatch" {
  name = "cloudTrail-cloudWatch-policy"
  role = aws_iam_role.cloud_trail.id

  policy = file("${path.module}/files/aws_iam_role_policy_cloudTrail_cloudWatch.json")
}