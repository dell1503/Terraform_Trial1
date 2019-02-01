#S3
resource "aws_s3_bucket" "bucket" {
  bucket = "bitcoin-3876412"
  acl    = "private"
  tags = {
    Name        = "bitcoindatadir"
    Environment = "Dev"
  }
}
