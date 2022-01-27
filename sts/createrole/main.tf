resource "aws_iam_role" "test" {
  name = "Litnupras"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        "AWS" = "arn:aws:iam::067819342479:user/yakdriver",
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}
