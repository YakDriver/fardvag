# only inline policy test
resource "aws_iam_role" "example" {
  name               = "yak_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  inline_policies = {
    yak_inline_test_policy = <<EOF
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

    another_inline_policy = "${data.aws_iam_policy_document.inline_policy.json}"
    just_an_inline_policy = <<QUE
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:ListBucket",
        "s3:HeadBucket"
      ],
      "Resource": "*"
    }
  ]
}
QUE
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
