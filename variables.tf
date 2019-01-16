variable "account_id" {}

variable "s3_bucket_force_destroy" {}

variable "key_names" {
  type = "list"
}

variable "common_tags" {
  type = "map"
}
