provider "aws" {
  version = "<= 1.52"
  region  = "us-east-1"
  profile = "credproc"
}

data "terraform_remote_state" "objects_bucket" {
  backend = "s3"

  config {
    bucket  = "yak-forsok"
    key     = "forsok-1.tfstate"
    region  = "us-east-1"
    profile = "giltig"
  }
}
