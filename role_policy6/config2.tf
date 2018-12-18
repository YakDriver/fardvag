# only inline policy test
resource "aws_iam_role" "example" {
  name               = "yak_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  inline_policy = []
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

data "aws_iam_policy_document" "inline_policy" {
  statement {

    actions   = ["ec2:DescribeAccountAttributes"]
    resources = ["*"]
  }
}
