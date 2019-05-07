resource "aws_s3_bucket" "object_bucket" {
  bucket = "aa-e9129be9-a027-593e-a9d6-938babf39963"
}

resource "aws_s3_bucket_object" "object" {
  bucket       = "${aws_s3_bucket.object_bucket.id}"
  key          = "testing"
  content      = "{\"name\":\"John\",\"age\":31,\"city\":\"New York\"}"
  content_type = "application/json"
}

data "aws_s3_bucket_object" "myobject" {
  bucket = "${aws_s3_bucket.object_bucket.id}"
  key    = "${aws_s3_bucket_object.object.id}"
}
