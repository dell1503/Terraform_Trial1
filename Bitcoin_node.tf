provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "develop" {
  key_name   = "develop"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGusJQ7Dzj43DZ0hyQqlM2IZgOJoVywBCHPOHmgCT/6AkVfePP/rlm+VGkPJ+9jvjxyFUu7709pMPHWXpll71jiFyA4B+9KOGgkyRLE0G8yGZXHsPEbEtqsPWxUMARa3mpJ1nO52I1C4bRsKGUyoGxCvs5+sxPgP0Gh7XCU6zzvDv/2q+7f+ot9UACaZ757E4Hhf7w20DQWVk42UljEBiHWl78VELzo1RgTOzKKQiJ3ZbQFnAAOwA/dIGOxQ3lad4mTE1JSaaWy/OwqfJDObhSRhzEYviHfWjvRrmIh6ycqYoDVwT+bjsdXa1sh2JF54qS7XQmPifFrWZ5Qj1e9bMp"
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
  iam_instance_profile  = "bitcoinec2" 
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
    private_key = "${file("~/.ssh/EC2_BTC.pem")}"
  }
}
