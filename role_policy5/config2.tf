resource "aws_iam_role" "role" {
  name               = "tf-acc-rpl-role-basic-vdxz"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "managed-policy2" {
  name = "tf-acc-rpl-policy-basic-2-vdxz"

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

resource "aws_iam_role_policy_attachment" "rpa" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.managed-policy2.arn}"
}
