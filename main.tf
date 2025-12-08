terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Ohio (the region shown in your screenshot)
  region = "us-east-2"
}

# Get the latest Amazon Linux 2 AMI in this region (no hard-coded ID)
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux2.id
  instance_type = "t2.micro"   # free-tier eligible

  tags = {
    Name = "tf-study-instance"
  }
}

#test
