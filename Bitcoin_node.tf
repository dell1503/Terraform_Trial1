provider "aws" {
  region = "eu-central-1"
}

# VPC 
/*
resource "aws_vpc" "mainvpc" {

  cidr_block = "10.0.0.0/16"
}
*/
#SecurityGroup
resource "aws_security_group" "ec2.bitcoinnode" {
  name        = "default"
  description = "default group, create SSH open"
  vpc_id      = "vpc-1775487c"

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
  security_groups = ["${aws_security_group.default.name}"]
  iam_instance_profile = "arn:aws:iam::061342987065:role/bitcoinec2"  
  tags = {
        Name        = "EC2"
        Environment = "Dev"
        }
  provisioner "local-exec" {
    command = "https://raw.githubusercontent.com/dell1503/BitcoinAutoNode/master/bitcoinAutoNode.sh ; sudo bash stub.sh"

}
}
