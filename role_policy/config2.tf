# only inline policy test
resource "aws_iam_role" "example" {
  name               = "yak_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  inline_policy {
    name = "yak_inline_test_policy"
    policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
  }

  inline_policy {
    name = "yak_inline_test_policy2"
    policy = "${data.aws_iam_policy_document.inline_policy.json}"
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

data "aws_iam_policy_document" "inline_policy" {
  statement {

    actions   = ["ec2:DescribeAccountAttributes"]
    resources = ["*"]
  }
}
