provider "aws" {
  region = "eu-central-1"
}

#EC2
resource "aws_instance" "example" {
  ami           = "ami-c1fa1cae"
  instance_type = "t2.micro"
  security_groups = [ "allow_all" ]
}

# Security Group
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_all"
  }
}