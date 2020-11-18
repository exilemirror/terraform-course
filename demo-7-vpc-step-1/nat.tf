# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-lab-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-lab-public-1.id
  depends_on    = [aws_internet_gateway.main-lab-gw]
}

# route tables for private
resource "aws_route_table" "main-lab-private" {
  vpc_id = aws_vpc.main-lab.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-lab-gw.id
  }

  tags = {
    Name = "rt-main-lab-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "main-lab-private-1-a" {
  subnet_id      = aws_subnet.main-lab-private-1.id
  route_table_id = aws_route_table.main-lab-private.id
}

resource "aws_route_table_association" "main-lab-private-2-a" {
  subnet_id      = aws_subnet.main-lab-private-2.id
  route_table_id = aws_route_table.main-lab-private.id
}


