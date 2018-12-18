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

  tags {
    Name = "yak-testing"
  }
}

resource "aws_route" "test" {
  route_table_id = "${aws_route_table.test.id}"
  destination_cidr_block = "10.1.0.0/16"
  gateway_id = "${aws_internet_gateway.test.id}"
}

output "test_id" {
  value = "${aws_route_table.test.id}"
}
