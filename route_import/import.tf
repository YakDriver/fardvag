variable "vpc_id" {}
variable "vpc_peering_conn_1" {}
variable "vpc_peering_conn_2" {}
variable "rt_name" {}

variable "destination_cidr_ipv4" {}
variable "destination_cidr_ipv6" {}
variable "rt_id" {}

resource "aws_route" "route_1" {
  route_table_id            = "${var.rt_id}"
  destination_cidr_block    = "${var.destination_cidr_ipv4}"
  vpc_peering_connection_id = "${var.vpc_peering_conn_1}"
}

output "rt_id" {
  value = "${aws_route.route_1.id}"
}
