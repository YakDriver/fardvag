resource "aws_s3_bucket" "object_bucket" {
  bucket = "tf-object-test-bucket-12345"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.object_bucket.bucket}"
  key    = "test-key"
  source = "s3://tf-object-test-source-12345/object-to-copy"
  content_language = "en"
}
