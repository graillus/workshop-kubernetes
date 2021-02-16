variable "aws_admin_users" {
  description = "Additional IAM admin users to add to the aws-auth configmap."
  type = list(string)
  default = []
}
variable "aws_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(string)
  default = []
}
