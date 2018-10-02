resource "aws_security_group" "prometheus_sg" {
  name        = "${var.env}-prometheus-sg"
  description = "${var.env}-prometheus-sg"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port       = 9090
    to_port         = 9094
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
    self            = false
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
    self            = false
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 123
    to_port         = 123
    protocol        = "udp"
    security_groups = ["${aws_security_group.ntp.id}"]
  }
}

resource "aws_security_group_rule" "extra_rule" {
  security_group_id        = "${aws_security_group.prometheus_sg.id}"
  from_port                = 9100
  to_port                  = 9491
  protocol                 = "-1"
  type                     = "egress"
  source_security_group_id = "${aws_security_group.logging_prometheus_sg.id}"
}

resource "aws_security_group" "logging_prometheus_sg" {
  name        = "${var.env}-logging-prometheus-sg"
  description = "${var.env}-logging-prometheus-sg"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port       = 9100
    to_port         = 9491
    protocol        = "tcp"
    security_groups = ["${aws_security_group.prometheus_sg.id}"]
    self            = false
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = ["aws_security_group.prometheus_sg"]
}
