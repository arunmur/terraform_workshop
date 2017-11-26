
/*
resource "aws_eip" "eip_nat_a" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_eip" "eip_nat_b" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = "${aws_eip.eip_nat_a.id}"
  subnet_id = "${aws_subnet.public_subnet_a.id}"
  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = "${aws_eip.eip_nat_b.id}"
  subnet_id = "${aws_subnet.public_subnet_b.id}"
  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_route_table" "private_route_table_a" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_a.id}"
  }

  tags {
    Name        = "Private Workshop Routes -> Nat A (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "private_route_table_b" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_b.id}"
  }

  tags {
    Name        = "Private Workshop Routes -> Nat B (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "private_a_route_table_association" {
    subnet_id = "${aws_subnet.private_subnet_a.id}"
    route_table_id = "${aws_route_table.private_route_table_a.id}"
}

resource "aws_route_table_association" "private_b_route_table_association" {
    subnet_id = "${aws_subnet.private_subnet_b.id}"
    route_table_id = "${aws_route_table.private_route_table_b.id}"
}

*/
