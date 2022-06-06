resource "aws_route_table" "IG_route_table" {
  depends_on = [
    aws_vpc.awslab-vpc,
    aws_internet_gateway.internet_gateway,
  ]

  vpc_id = aws_vpc.awslab-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "IG-route-table"
  }
}

# associate route table to public subnet
resource "aws_route_table_association" "associate_routetable_to_awslab-subnet-public" {
  depends_on = [
    aws_subnet.awslab-subnet-public,
    aws_route_table.IG_route_table,
  ]
  subnet_id      = aws_subnet.awslab-subnet-public.id
  route_table_id = aws_route_table.IG_route_table.id
}
