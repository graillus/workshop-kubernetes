# This resource should be imported in tfstate once created
# ex : terraform import aws_s3_bucket.elvlabs-terraform-state elvlabs-terraform-state
resource "aws_s3_bucket" "elvlabs-terraform-state" {
  bucket = "elvlabs-terraform-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    terraformed = "true"
  }
}
