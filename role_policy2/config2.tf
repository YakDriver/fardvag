resource "aws_iam_role" "example" {
  name = "yak_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  managed_policy_arns = [
    "${aws_iam_policy.policy_one.arn}",
    "${aws_iam_policy.policy_two.arn}",
    "${aws_iam_policy.policy_three.arn}",
  ]

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

resource "aws_iam_policy" "policy_three" {
  name        = "yak_test_policy3"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
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
EOF
}
