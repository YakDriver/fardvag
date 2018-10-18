resource "aws_iam_role" "example" {
  name = "yak_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  inline_policies_exclusive = true
  inline_policies = {
    
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
