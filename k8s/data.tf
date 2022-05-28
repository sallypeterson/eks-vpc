# vpc
data "aws_vpc" "my" {
  tags = {
    Name = "my-vpc"
  }
}

# subnets
data "aws_subnet" "my_private_us_east_1a" {
  vpc_id = data.aws_vpc.my.id
  tags = {
    Name = "my-vpc-private-us-east-1a"
  }
}

data "aws_subnet" "my_private_us_east_1b" {
  vpc_id = data.aws_vpc.my.id
  tags = {
    Name = "my-vpc-private-us-east-1b"
  }
}

data "aws_subnet" "my_private_us_east_1c" {
  vpc_id = data.aws_vpc.my.id
  tags = {
    Name = "my-vpc-private-us-east-1c"
  }
}

data "aws_subnet" "my_public_us_east_1a" {
  vpc_id = data.aws_vpc.my.id
  tags = {
    Name = "my-vpc-public-us-east-1a"
  }
}

data "aws_subnet" "my_public_us_east_1b" {
  vpc_id = data.aws_vpc.my.id
  tags = {
    Name = "my-vpc-public-us-east-1b"
  }
}

data "aws_subnet" "my_public_us_east_1c" {
  vpc_id = data.aws_vpc.my.id
  tags = {
    Name = "my-vpc-public-us-east-1c"
  }
}

locals {
  my_private_subnets = [data.aws_subnet.my_private_us_east_1a.id, data.aws_subnet.my_private_us_east_1b.id, data.aws_subnet.my_private_us_east_1c.id]
  my_public_subnets  = [data.aws_subnet.my_public_us_east_1a.id, data.aws_subnet.my_public_us_east_1b.id, data.aws_subnet.my_public_us_east_1c.id ]
}

# tags
locals {
  tags = {
    Managed     = "Terraform"
    Service     = "Dummy"
    Environment = "Dev"
    Resource    = "K8s"
  }
}