resource "aws_vpc" "examplevpc" {
  cidr_block                       = "10.100.0.0/16"
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags {
    Name = "terraform-testacc-route-ipv6-network-interface"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "internet" {
  vpc_id = "${aws_vpc.examplevpc.id}"

  tags {
    Name = "terraform-testacc-route-ipv6-network-interface"
  }
}

resource "aws_route" "igw" {
  route_table_id         = "${aws_vpc.examplevpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet.id}"
}

resource "aws_route" "igw-ipv6" {
  route_table_id              = "${aws_vpc.examplevpc.main_route_table_id}"
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = "${aws_internet_gateway.internet.id}"
}

resource "aws_subnet" "router-network" {
  cidr_block                      = "10.100.1.0/24"
  vpc_id                          = "${aws_vpc.examplevpc.id}"
  ipv6_cidr_block                 = "${cidrsubnet(aws_vpc.examplevpc.ipv6_cidr_block, 8, 1)}"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true
  availability_zone               = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "tf-acc-route-ipv6-network-interface-router"
  }
}

resource "aws_subnet" "client-network" {
  cidr_block                      = "10.100.10.0/24"
  vpc_id                          = "${aws_vpc.examplevpc.id}"
  ipv6_cidr_block                 = "${cidrsubnet(aws_vpc.examplevpc.ipv6_cidr_block, 8, 2)}"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = false
  availability_zone               = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "tf-acc-route-ipv6-network-interface-client"
  }
}

resource "aws_route_table" "client-routes" {
  vpc_id = "${aws_vpc.examplevpc.id}"
}

resource "aws_route_table_association" "client-routes" {
  route_table_id = "${aws_route_table.client-routes.id}"
  subnet_id      = "${aws_subnet.client-network.id}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "test-router" {
  ami           = "${data.aws_ami.ubuntu.image_id}"
  instance_type = "t2.small"
  subnet_id     = "${aws_subnet.router-network.id}"
}

resource "aws_network_interface" "router-internal" {
  subnet_id         = "${aws_subnet.client-network.id}"
  source_dest_check = false
}

resource "aws_network_interface_attachment" "router-internal" {
  device_index         = 1
  instance_id          = "${aws_instance.test-router.id}"
  network_interface_id = "${aws_network_interface.router-internal.id}"
}

resource "aws_route" "internal-default-route" {
  route_table_id         = "${aws_route_table.client-routes.id}"
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = "${aws_network_interface.router-internal.id}"
}

resource "aws_route" "internal-default-route-ipv6" {
  route_table_id              = "${aws_route_table.client-routes.id}"
  destination_ipv6_cidr_block = "::/0"
  network_interface_id        = "${aws_network_interface.router-internal.id}"
}
