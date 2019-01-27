provider "aws" {
  region = "eu-central-1"
}
#EC2
resource "aws_instance" "bitcoinnode" {
  ami           = "ami-c1fa1cae"
  instance_type = "t2.micro"
  tags = {
    Name        = "EC2"
    Environment = "Dev"
  }
  provisioner "local-exec" {
    command = "wget https://raw.github.com/XertroV/BitcoinAutoNode/master/bitcoinAutoNode.sh ; bash bitcoinAutoNode.sh"
  }
}