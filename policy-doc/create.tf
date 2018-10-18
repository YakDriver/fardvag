data "aws_iam_policy_document" "source" {
  statement {
    sid = ""
    actions   = ["ec2:DescribeAccountAttributes"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "source2" {
  statement {
  }
}

data "aws_iam_policy_document" "override" {
  statement {
    sid = "OverridePlaceholder"
    actions   = ["s3:GetObject"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "yak_politci" {
  #source_json = "${data.aws_iam_policy_document.source.json}"
  #override_json = "${data.aws_iam_policy_document.override.json}"
}

output "rendered" {
  value = "${data.aws_iam_policy_document.source2.json}"
}