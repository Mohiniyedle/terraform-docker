resource "aws_s3_bucket" "dev_bucket" {
  bucket = "gajanan-bucket"
  acl    = "log-delivery-write"
}