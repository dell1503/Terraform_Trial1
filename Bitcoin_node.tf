provider "aws" {
  region = "eu-central-1"
}

# VPC
resource "aws_vpc" "mainvpc" {
  cidr_block = "10.0.0.0/16"
}
#SecurityGroup
resource "aws_security_group" "default" {
  name        = "default"
  description = "default group, create SSH open"
  vpc_id      = "${resource.aws_vpc.mainvpc}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#EC2
resource "aws_instance" "bitcoinnode" {
  ami           = "ami-0bdf93799014acdc4"                                             #Ubuntu18.04 LTS,hvm:ebs-ssd
  instance_type = "t2.micro"
  security_groups = [
        "${aws_security_group.first.id}"
    ]
  IAM ROLE ATTACHEN
  tags = {
    Name        = "EC2"
    Environment = "Dev"
  }
  provisioner "local-exec" {
    #command = "https://raw.githubusercontent.com/dell1503/BitcoinAutoNode/master/bitcoinAutoNode.sh"
  }
}
