resource "aws_iam_role" "role" {
  name               = "tf-acc-rpl-role-empty-16c1"
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

resource "aws_iam_role_policy_list" "rpl" {
  name            = "tf-acc-rpl-empty-16c1"
  role            = "${aws_iam_role.role.name}"
  inline_policies = []
}
