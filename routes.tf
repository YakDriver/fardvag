variable "subnet_id" {}
variable "destination_cidr" {}
variable "target" {}

data "aws_route_table" "selected" {
  subnet_id = "${var.subnet_id}"
}

resource "aws_route" "route" {
  route_table_id            = "${data.aws_route_table.selected.id}"
  destination_cidr_block    = "${var.destination_cidr}"
  vpc_peering_connection_id = "${var.target}"
}