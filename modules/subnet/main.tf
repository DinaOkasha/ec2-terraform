
resource "aws_subnet" "main_dina_subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block

  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
  }

resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env_prefix}-igw"
  }

}


resource "aws_route_table" "dina_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.env_prefix}-rtb"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_dina_subnet.id
  route_table_id = aws_route_table.dina_route_table.id
}
