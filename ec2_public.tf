resource "aws_security_group" "sg_public_awslab" {
  depends_on = [
    aws_vpc.awslab-vpc,
  ]

  name        = "security group public awslab"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.awslab-vpc.id

  ingress {
    description = "allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
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

# public ec2 instance
resource "aws_instance" "web" {
  depends_on = [
    aws_security_group.sg_public_awslab,
    aws_instance.database
  ]
  ami = "ami-0ca285d4c2cda3300"
  instance_type = "t2.micro"
  key_name = var.key_cocus
  vpc_security_group_ids = [aws_security_group.sg_public_awslab.id]
  subnet_id = aws_subnet.awslab-subnet-public.id
    tags = {
      Name = "web-instance"
     } 
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 8
    volume_type = "gp2"
    tags = {
      Name = "web-disk"
    }
  }
}
