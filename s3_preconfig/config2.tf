resource "aws_s3_bucket" "source" {
  bucket = "tf-object-test-source-12345"
}

resource "aws_s3_bucket_object" "source-obj" {
  bucket  = "${aws_s3_bucket.source.id}"
  key     = "object-to-copy"
  content = "bar"
  content_language = "es"
}
