# VPC の作成
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_block}"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "${var.tag}"
  }
}

# Zone 1a に DMZ subnet を作成
resource "aws_subnet" "subnet1a_DMZ" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_subnet_1a_DMZ}"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "public_subnet_1a"
  }
}

# Zone 1c に DMZ subnet を作成
resource "aws_subnet" "subnet1c_DMZ" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_subnet_1c_DMZ}"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags {
    Name = "public_subnet_1c"
  }
}

# Zone 1a に TRUST subnet を作成
resource "aws_subnet" "subnet1a_TRUST" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_subnet_1a_TRUST}"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags {
    Name = "private_subnet_1a"
  }
}

# Zone 1c に TRUST subnet を作成
resource "aws_subnet" "subnet1c_TRUST" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_subnet_1c_TRUST}"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.tag}"
  }
}

# internet gateway の作成
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "private_subnet_1c"
  }
}

# routing table の作成
resource "aws_route_table" "routing" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "${var.tag}"
  }
}

# zone 1a の DMZ subnet に routing table を適用
resource "aws_route_table_association" "subnet1a_DMZ" {
  subnet_id = "${aws_subnet.subnet1a_DMZ.id}"
  route_table_id = "${aws_route_table.routing.id}"
}

# zone 1c の DMZ subnet に routing table を適用
resource "aws_route_table_association" "subnet1c_DMZ" {
  subnet_id = "${aws_subnet.subnet1c_DMZ.id}"
  route_table_id = "${aws_route_table.routing.id}"
}
