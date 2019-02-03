#S3
resource "aws_s3_bucket" "bucket" {
  bucket = "bitcoin-3876412"
  policy = "${file("policys3bucket.json")}"
  tags = {
    Name        = "bitcoindatadir"
    Environment = "Dev"
  }
}
