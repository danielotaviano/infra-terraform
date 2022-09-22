terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "allow_ports" {
  name        = "allow_ports"
  description = "Allow ports"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ports"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-017fecd1353bcc96e"
  instance_type = "t2.micro"

  key_name = "aws-terraform"

  tags = {
    Name = "Primeira Instancia"
  }

  vpc_security_group_ids = [
    aws_security_group.allow_ports.id,
  ]
}
