#S3
resource "aws_s3_bucket" "bucket" {
  bucket = "bitcoin-3876412"
  tags = {
    Name        = "bitcoindatadir"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "statebucket" {
  bucket = "terraform-state-bucket-dell1503"
  acl    = "private"

  versioning {
    enabled = true
  }
}