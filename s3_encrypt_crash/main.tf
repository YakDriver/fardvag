provider "aws" {}

variable "sse_algorithm" {
  description = "The algorithm to use for server side encryption"
  type        = "string"
}

resource "aws_s3_bucket" "encrypted" {

  bucket = "yak-test-2000"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
      }
    }
  }
}
