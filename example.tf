provider "aws" {
  region = "eu-central-1"
}

#S3
resource "aws_s3_bucket" "bucket" {
  bucket = "bitcoindatadir"
  acl    = "private"
  /*
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::bitcoindatadir/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "94.78.17.242/32"}
      }
    }
  ]
}
POLICY
*/
  tags = {
    Name        = "bitcoindatadir"
    Environment = "Dev"
  }
}

# 94.78.17.242

/*
#EC2
resource "aws_instance" "example" {
  ami           = "ami-c1fa1cae"
  instance_type = "t2.micro"
  security_groups = [ "allow_all" ]
  tags = {
    Name        = "EC2"
    Environment = "Dev"
  }
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
    Name        = "SG"
    Environment = "Dev"
  }
}
*/