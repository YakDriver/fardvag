provider "aws" {
  region  = "us-east-1"
  profile = "credproc"
}

resource "aws_s3_bucket_object" "object1" {
  bucket  = "yak-forsok"
  key     = "arch/three_gossips/turret"
  content = "Delicate"
}
