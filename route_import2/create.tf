resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"

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

resource "aws_route_table" "test" {
  vpc_id = "${aws_vpc.test.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test.id}"
  }

  tags {
    Name = "yak-testing"
  }
}

resource "aws_route" "test" {
}

output "test_id" {
  value = "${aws_route_table.test.id}"
}
