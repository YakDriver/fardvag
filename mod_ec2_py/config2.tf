provider "aws" {
  version = "~> 1.56"
  region  = "us-east-1"
}

module "win-python-ec2" {
  source         = "plus3it/win-python-ec2/aws"
  version        = "1.0.2"
}

output "win_pass" {
  description = "Randomly generated password assigned to Admin account"
  value       = "${module.win-python-ec2.win_pass}"
  sensitive   = true
}
