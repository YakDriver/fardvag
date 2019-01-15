data "aws_s3_bucket_objects" "yesh" {
  bucket = "watchmaker-dev"
  prefix = "releases/0.10.1.dev20180905"
}

output "test_id" {
  value = "${data.aws_s3_bucket_objects.yesh.id}"
}

output "test_keys" {
  value = "${data.aws_s3_bucket_objects.yesh.keys}"
}

output "test_prefixes" {
  value = "${data.aws_s3_bucket_objects.yesh.common_prefixes}"
}

output "test_owners" {
  value = "${data.aws_s3_bucket_objects.yesh.owners}"
}
