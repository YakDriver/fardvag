variable "vpc_id" {}
variable "vpc_peering_conn_1" {}
variable "vpc_peering_conn_2" {}
variable "rt_name" {}

variable "destination_cidr_ipv4" {}
variable "destination_cidr_ipv6" {}

resource "aws_route_table" "rt" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block                = "${var.destination_cidr_ipv4}"
    vpc_peering_connection_id = "${var.vpc_peering_conn_1}"
  }

  route {
    ipv6_cidr_block           = "${var.destination_cidr_ipv6}"
    vpc_peering_connection_id = "${var.vpc_peering_conn_2}"
  }

  tags {
    Name = "${var.rt_name}"
  }
}

output "rt_id" {
  value = "${aws_route_table.rt.id}"
}
