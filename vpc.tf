resource "aws_vpc" "awslab-vpc" {
  cidr_block       = "172.16.0.0/23"
  instance_tenancy = "default"

  tags = {
    Name = "awslab-vpc"
  }

  enable_dns_hostnames = true
}
