resource "aws_subnet" "awslab-subnet-public" {
  depends_on = [
    aws_vpc.awslab-vpc,
  ]

  vpc_id     = aws_vpc.awslab-vpc.id
  cidr_block = "172.16.0.0/24"

  tags = {
    Name = "public-subnet"
  }

  map_public_ip_on_launch = true
}

resource "aws_subnet" "awslab-subnet-private" {
  depends_on = [
    aws_vpc.awslab-vpc,
  ]

  vpc_id     = aws_vpc.awslab-vpc.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "private-subnet"
  }
}
