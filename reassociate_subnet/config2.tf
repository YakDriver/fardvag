locals {
  region = "us-east-1"
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/23"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_internet_gateway" "test" {
  vpc_id = "${aws_vpc.test.id}"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_subnet" "client-network" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = "${aws_vpc.test.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${local.region}a"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_route_table" "client-routes" {
  vpc_id = "${aws_vpc.test.id}"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_route_table_association" "client-routes" {
  route_table_id = "${aws_route_table.client-routes.id}"
  subnet_id      = "${aws_subnet.client-network.id}"
}
