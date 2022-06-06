resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [
    aws_vpc.awslab-vpc,
  ]

  vpc_id = aws_vpc.awslab-vpc.id

  tags = {
    Name = "internet-gateway"
  }
}
