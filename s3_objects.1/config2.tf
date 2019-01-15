resource "aws_s3_bucket" "objects_bucket" {
  bucket = "tf-objects-test-bucket-12345"
}

resource "aws_s3_bucket_object" "object1" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/three_gossips/turret"
  content = "Delicate"
}

resource "aws_s3_bucket_object" "object2" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/three_gossips/broken"
  content = "Dark Angel"
}

resource "aws_s3_bucket_object" "object3" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/navajo/north_window"
  content = "Balanced Rock"
}

resource "aws_s3_bucket_object" "object4" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/navajo/sand_dune"
  content = "Queen Victoria Rock"
}

resource "aws_s3_bucket_object" "object5" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/partition/park_avenue"
  content = "Double-O"
}

resource "aws_s3_bucket_object" "object6" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/courthouse_towers/landscape"
  content = "Fiery Furnace"
}

resource "aws_s3_bucket_object" "object7" {
  bucket  = "${aws_s3_bucket.objects_bucket.id}"
  key     = "arch/rubicon"
  content = "Devils Garden"
}

data "aws_s3_bucket_objects" "yesh" {
  bucket      = "${aws_s3_bucket.objects_bucket.id}"
  prefix      = "arch/three_gossips/"
  fetch_owner = true
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
