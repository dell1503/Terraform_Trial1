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
resource "aws_security_group" "ec2bitcoinnode" {
  name        = "ec2bitcoinnode"
  description = "Security Group for EC2 isntance of Bitcoinnode"
  vpc_id      = "vpc-1775487c"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#EC2
resource "aws_instance" "bitcoinnode" {
  ami                   = "ami-0bdf93799014acdc4"                                             #Ubuntu18.04 LTS,hvm:ebs-ssd
  instance_type         = "t2.micro"
  security_groups       = ["${aws_security_group.ec2bitcoinnode.name}"]
  iam_instance_profile  = "bitcoinec2" 
  key_name              = "EC2_BTC"
  tags                  = {
                          Name        = "EC2"
                          Environment = "Dev"
                          }
  provisioner "local-exec" {
    command = "wget https://raw.githubusercontent.com/dell1503/BitcoinAutoNode/master/bitcoinAutoNode.sh ; sudo bash bitcoinAutoNode.sh"

}
}
