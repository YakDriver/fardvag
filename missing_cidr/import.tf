variable "rt_id" {}
variable "vpc_peering_conn_1" {}

resource "aws_route" "route_1" {
  route_table_id            = "${var.rt_id}"
  destination_cidr_block    = "124.0.0.0/16"
  vpc_peering_connection_id = "${var.vpc_peering_conn_1}"
}
