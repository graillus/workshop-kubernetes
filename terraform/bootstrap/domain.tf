resource "aws_route53_zone" "elvlabs-workshop-domain" {
  name = "k8s-workshop.eleven-labs.com"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    terraformed = "true"
  }
}
