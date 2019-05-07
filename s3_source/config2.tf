resource "aws_s3_bucket" "object_bucket" {
  bucket = "aa-1832697d-1602-55c7-9fa2-14946cec1e16"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "aa-1832697d-1602-55c7-9fa2-14946cec1e16"
  key    = "copied-object"
  source = "s3://aa-1832697d-1602-55c7-9fa2-14946cec1e16/object-to-copy"
  #content_language = "en"
  #content_type = "binary/octet-stream"
}
