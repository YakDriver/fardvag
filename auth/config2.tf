provider "aws" {
  #profile = "credproc"
  region  = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/YAK-TEST-ROLE-S3"
    session_name = "yo-session"
    external_id  = "23be7ac0-9dee-5681-b949-eaa5468c2f99"
  }
}

resource "aws_s3_bucket_object" "object1" {
  bucket  = "yak-forsok"
  key     = "arch/three_gossips/turret"
  content = "Delicate"
}
