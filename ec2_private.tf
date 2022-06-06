resource "aws_security_group" "sg_private_awslab" {
  depends_on = [
    aws_vpc.awslab-vpc,
  ]
  name        = "security group private awslab"
  vpc_id      = aws_vpc.awslab-vpc.id

  ingress {
    description = "allow TCP"
    from_port   = 3110
    to_port     = 3110
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_public_awslab.id]
  }

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_public_awslab.id]
  }

  egress {
    description = "allow ICMP"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# database ec2 instance
resource "aws_instance" "database" {
  depends_on = [
    aws_security_group.sg_private_awslab,
  ]
  ami = "ami-00af37d1144686454"
  instance_type = "t2.micro"
  availability_zone = "us-west-2a"
  key_name = var.key_cocus
  vpc_security_group_ids = [aws_security_group.sg_private_awslab.id]
  subnet_id = aws_subnet.awslab-subnet-private.id
    tags = {
      Name = "database-instance"
     }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 8
    volume_type = "gp2"
    tags = {
      Name = "database-disk"
    }
  }
}
