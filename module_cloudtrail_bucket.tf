module "cloudtrail_bucket" {
  source                  = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name          = "cloudtail-${data.aws_caller_identity.current.account_id}"
  s3_bucket_policy        = "${data.template_file.cloudtrail_policy.rendered}"
  s3_bucket_force_destroy = "${var.s3_bucket_force_destroy}"
  common_tags             = "${var.common_tags}"
}

resource "aws_cloudtrail" "cloudtrail" {
  name = "Default"
  s3_bucket_name = "cloudtail-${data.aws_caller_identity.current.account_id}"
  include_global_service_events = true
  is_multi_region_trail = true
  enable_log_file_validation = true

}