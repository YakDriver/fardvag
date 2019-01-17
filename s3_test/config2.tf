resource "aws_s3_bucket" "yesh" {
  bucket = "vihn-test"
}

resource "aws_s3_bucket_object" "object" {
  bucket  = "${aws_s3_bucket.yesh.id}"
  key     = "new_object_key"
  content = "This is the file contents!"
}

output "test_id" {
  value = "${aws_s3_bucket.yesh.id}"
}
