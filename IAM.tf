#BitcoinEC2 to S3 Policy

#Create Role
resource "aws_iam_role" "bitcoinec2_role" {
  name = "bitcoinec2_role"
  assume_role_policy = "${file("jsons/iam_role_assume_ec.json")}"
}
# Create S3 Bucket Policy
resource "aws_iam_policy" "ec2tos3btc" {
  name        = "ec2tos3btc"
  description = "Give Access to BTC S3 Buckets"
  #policy      = "${file("IAM_policys_access_s3.json")}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.bucket}"
        }
    ]
}
EOF
}
resource "aws_iam_policy_attachment" "s3_to_ec2_attachment" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.bitcoinec2_role.name}"]
  policy_arn = "${aws_iam_policy.ec2tos3btc.arn}"
}