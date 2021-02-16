# See https://github.com/hashicorp/learn-terraform-provision-eks-cluster
# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster), containing
Terraform configuration files to provision an EKS cluster on AWS.

First, edit provider.tf to match your current backend configuration (or remove s3 backend)

Then, export these environment variables (or create a default section in ~/.aws/credentials) :
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

Edit terraform.tfvars.json for additional users :
{
  "aws_admin_users": [
    "rgraillon"
  ],
  "aws_users": [
    "fnguyen",
    "tgauvin"
  ]
}
(a dedicated namespace is created for each user)

To setup kubeconfig : `aws eks --region eu-west-3 update-kubeconfig --name <cluster_name>`

To setup aws-load-balancer-controller :
- https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
- https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

To setup external-dns :
- https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md
