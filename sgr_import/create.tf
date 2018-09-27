resource "aws_security_group" "yak-deleterious" {
  name        = "yak-deleterious"
  description = "Scheduled for termination"

  tags {
    Name = "yak-deleterious"
  }
}

resource "aws_security_group_rule" "orak-clay" {
  security_group_id = "${aws_security_group.yak-deleterious.id}"

  type        = "ingress"
  from_port   = 1521
  to_port     = 1521
  protocol    = "tcp"
  cidr_blocks = ["10.1.0.0/16"]
}

output "sg_id" {
  value = "${aws_security_group.yak-deleterious.id}"
}
