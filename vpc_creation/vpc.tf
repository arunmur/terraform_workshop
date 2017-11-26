provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}


resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.environment}-${var.vpc_name}"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet_a_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
  tags = {
  	Name        = "Workshop Public Subnet A (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet_b_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}b"
  tags = {
  	Name        = "Workshop Public Subnet B (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${var.aws_region}a"
  cidr_block        = "${var.private_subnet_a_cidr}"
  tags = {
    Name        = "Workshop Private Subnet A (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${var.aws_region}b"
  cidr_block        = "${var.private_subnet_b_cidr}"
  tags = {
    Name        = "Workshop Private Subnet B (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_default_route_table" "routing" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }

  tags {
    Name        = "Public Workshop Routes (${var.environment})"
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    App         = "Workshop"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "default_allow_all_local" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["${var.vpc_cidr}"]

  security_group_id = "${aws_default_security_group.default.id}"
}


resource "aws_security_group_rule" "default_can_talk_locally" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["${var.vpc_cidr}"]

  security_group_id = "${aws_default_security_group.default.id}"
}

resource "aws_security_group_rule" "default_can_talk_to_the_world" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_default_security_group.default.id}"
}

resource "aws_route53_zone" "cluster" {
  name         = "${var.cluster_private_dns}"
  vpc_id       = "${aws_vpc.vpc.id}"

  tags {
    Name          = "${var.environment} Workshop internal DNS"
    App           = "Workshop"
    Environment   = "${var.environment}" 
  }
}
