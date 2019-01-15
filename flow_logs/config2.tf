locals {
  region = "us-gov-west-1"
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/24"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_internet_gateway" "test" {
  vpc_id = "${aws_vpc.test.id}"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_cloudwatch_log_group" "upagro" {
  name = "yak"

  tags = {
    Name = "yak-testing"
  }
}

resource "aws_flow_log" "test" {
  iam_role_arn         = "${aws_iam_role.test.arn}"
  log_group_name       = "${aws_cloudwatch_log_group.upagro.name}"
  vpc_id               = "${aws_vpc.test.id}"
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
}

resource "aws_iam_role" "test" {
  name               = "yak-test-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["logs.${local.region}.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "test" {
  name   = "yak-test-policy"
  role   = "${aws_iam_role.test.id}"
  policy = "${data.aws_iam_policy_document.policy.json}"
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.upagro.arn}"]
  }
}
