variable "vpc_id" {}
variable "vpc_peering_conn_1" {}
variable "vpc_peering_conn_2" {}

terraform {
  required_version = "0.11.8"
}

provider "aws" {
  region  = "us-east-1"
  version = "1.33.0"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "yak-testing"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block                = "123.0.0.0/16"
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
