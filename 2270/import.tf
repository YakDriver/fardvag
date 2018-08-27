variable "rt_id" {}

variable "another_ni_id" {}

resource "aws_route" "internal-default-route" {
  route_table_id = "${var.rt_id}"
  destination_cidr_block = "124.0.0.0/16"
  network_interface_id = "${var.another_ni_id}"
}
