locals {
  region = "us-east-1"
}

resource "aws_route_table" "new_guy" {
  vpc_id = "vpc-01d03e11b3ae8bbe2"

  tags {
    Name = "yak-testing2"
  }
}

resource "aws_route_table_association" "new_assoc" {
  route_table_id = "${aws_route_table.new_guy.id}"
  subnet_id      = "subnet-04ff24b9b39f3822b"
  force_replace  = true
}
