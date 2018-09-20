resource "aws_iam_role_policy_list" "rpl" {
  name = "yak_testing_role_policy_list"

  managed_policies = [
    "${aws_iam_policy.policy_one.arn}",
    "${aws_iam_policy.policy_two.arn}",
  ]

  inline_policies = [
    "${aws_iam_role_policy.inline_test_policy.name}",
  ]

  role = "${aws_iam_role.instance_role.name}"
}

resource "aws_iam_role_policy" "inline_test_policy" {
  name = "yak_inline_test_policy"
  role = "${aws_iam_role.instance_role.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
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

resource "aws_iam_role" "instance_role" {
  name               = "yak_instance_role"
  path               = "/system/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_policy" "policy_one" {
  name        = "yak_test_policy1"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy_two" {
  name        = "yak_test_policy2"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
