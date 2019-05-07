resource "aws_s3_bucket" "source" {
  bucket = "aa-1832697d-1602-55c7-9fa2-14946cec1e16"
}

resource "aws_s3_bucket_object" "source-obj" {
  bucket  = "${aws_s3_bucket.source.id}"
  key     = "object-to-copy"
  content = "bar"
  content_language = "es"
  content_encoding = "gzip"
  cache_control = "no-cache"
  content_type = "text/html"
}
