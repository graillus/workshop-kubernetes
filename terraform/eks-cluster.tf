data "aws_caller_identity" "current" {}

locals {
  map_admin_users = [
    for i in range(length(var.aws_admin_users)) :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.aws_admin_users[i]}"
      username = var.aws_admin_users[i]
      groups   = ["system:masters"]
    }
  ]
  map_users = [
    for i in range(length(var.aws_users)) :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.aws_users[i]}"
      username = var.aws_users[i]
      groups   = ["workshop:users"]
    }
  ]
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets

  # Require awscli >= 1.16.156
  kubeconfig_aws_authenticator_command = "aws"
  kubeconfig_aws_authenticator_command_args = [
    "eks",
    "get-token",
    "--cluster-name",
    data.aws_eks_cluster.cluster.name
  ]

  map_users = concat(local.map_admin_users, local.map_users)

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t3a.large"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t3a.xlarge"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
