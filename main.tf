terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-dell1503"
    key    = "path/to/my/key"
    region = "eu-central-1"
  }
}