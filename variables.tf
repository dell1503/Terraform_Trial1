variable "bucket" {
  description = "BTC Bucket which the DATA will be stored"
}
variable "aws_region" {
  description = "The region to provision AWS resources in."
}

variable "availability_zone" {
  description = ""
}
variable "EC2_BTC_KEY" {}
/*
variable "EC2_BTC_KEY"{
  type = "string"
  description = ""
}*/