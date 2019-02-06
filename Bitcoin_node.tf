provider "aws" {  
  region = "${var.aws_region}"
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
    ingress {
    from_port   = 8333
    to_port     = 8333
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


#EC2
resource "aws_instance" "bitcoinnode" {
  ami                   = "ami-0bdf93799014acdc4"                                             #Ubuntu18.04 LTS,hvm:ebs-ssd
  instance_type         = "t2.medium"
  security_groups       = ["${aws_security_group.ec2bitcoinnode.name}"]
  iam_instance_profile  = "${aws_iam_role.bitcoinec2_role.name}"
  key_name              = "EC2_BTC"
  depends_on            = ["aws_s3_bucket.bucket"]
  tags                  = {
                          Name        = "EC2"
                          Environment = "Dev"
                          }

  provisioner "remote-exec" {
    inline = [
      "cd ~/",
      "wget https://raw.githubusercontent.com/dell1503/Terraform_Trial1/master/Scripts/bitcoinnodescript.sh",
      "sudo bash bitcoinnodescript.sh",
      "wget https://raw.githubusercontent.com/dell1503/Terraform_Trial1/master/Scripts/User_Cron_Start.sh",
      "bash User_Cron_Start.sh",
    ]
  }
  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    # Require to Export Env. Variable e.g export EC2_BTC_KEY=`cat ~/.ssh/EC2_BTC.pem`
    private_key = "${String.EC2_BTC_KEY.Data}"
  }
}
