#S3
resource "aws_s3_bucket" "bucket" {
  bucket = "bitcoindatadir"
  acl    = "private"
  tags = {
    Name        = "bitcoindatadir"
    Environment = "Dev"
  }
}
