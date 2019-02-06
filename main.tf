terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-dell1503"
    key    = "dell1503/terraform-state-bucket.tfstate"
    region = "eu-central-1"
  }
}