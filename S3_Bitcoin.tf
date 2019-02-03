#S3
resource "aws_s3_bucket" "bucket" {
  bucket = "bitcoin-3876412"
  tags = {
    Name        = "bitcoindatadir"
    Environment = "Dev"
  }
}
