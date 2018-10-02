resource "aws_security_group" "yak_sg" {
  name        = "yak-yak-sg"
  description = "yak-yak-sg"
}

resource "aws_security_group_rule" "extra_rule" {
  security_group_id        = "${aws_security_group.yak_sg.id}"
  from_port                = 9100
  to_port                  = 9491
  protocol                 = "-1"
  type                     = "egress"
  source_security_group_id = "${aws_security_group.logging_yak_sg.id}"
}

resource "aws_security_group" "logging_yak_sg" {
  name        = "yak-logging-yak-sg"
  description = "yak-logging-yak-sg"

  ingress {
    from_port       = 9100
    to_port         = 9491
    protocol        = "tcp"
    security_groups = ["${aws_security_group.yak_sg.id}"]
    self            = false
  }

  depends_on = ["aws_security_group.yak_sg"]
}
