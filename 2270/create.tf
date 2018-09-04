resource "aws_vpc" "examplevpc" {
  cidr_block                       = "10.100.0.0/16"
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags {
    Name = "yakdriver-terraform-test-2270"
  }
}

resource "aws_subnet" "client-network" {
  cidr_block                      = "10.100.10.0/24"
  vpc_id                          = "${aws_vpc.examplevpc.id}"
  ipv6_cidr_block                 = "${cidrsubnet(aws_vpc.examplevpc.ipv6_cidr_block, 8, 2)}"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = false
  availability_zone               = "us-west-2c"

  tags {
    Name = "yakdriver-terraform-test-2270"
  }
}

resource "aws_route_table" "client-routes" {
  vpc_id = "${aws_vpc.examplevpc.id}"

  tags {
    Name = "yakdriver-terraform-test-2270"
  }
}

resource "aws_route_table_association" "client-routes" {
  route_table_id = "${aws_route_table.client-routes.id}"
  subnet_id      = "${aws_subnet.client-network.id}"
}

resource "aws_network_interface" "router-internal" {
  subnet_id         = "${aws_subnet.client-network.id}"
  source_dest_check = false

  tags {
    Name = "yakdriver-terraform-test-2270"
  }
}

resource "aws_network_interface" "another-ni" {
  subnet_id         = "${aws_subnet.client-network.id}"
  source_dest_check = false

  tags {
    Name = "yakdriver-terraform-test-2270"
  }
}

resource "aws_route" "internal-default-route" {
  route_table_id         = "${aws_route_table.client-routes.id}"
  destination_cidr_block = "124.0.0.0/16"
  network_interface_id   = "${aws_network_interface.router-internal.id}"
}

output "rt_id" {
  value = "${aws_route_table.client-routes.id}"
}

output "another_ni_id" {
  value = "${aws_network_interface.another-ni.id}"
}

output "r_id" {
  value = "${aws_route.internal-default-route.id}"
}
