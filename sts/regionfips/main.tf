terraform {
  required_providers {
    aws = {
      source = "yakdriver.com/hashicorp/aws"
      version = ">= 1.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::067819342479:role/Litnupras"
  }

  endpoints {
    sts = "https://sts-fips.us-west-2.amazonaws.com"
  }
}

data "aws_caller_identity" "this" {}

//aws sts assume-role --role-arn arn:aws:iam::067819342479:role/Litnupras --role-session-name SESSION_NAME --endpoint-url https://sts-fips.us-west-2.amazonaws.com --region us-west-2