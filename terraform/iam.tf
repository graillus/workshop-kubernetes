data "aws_iam_policy" "iam_manage_own_creds" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

data "aws_iam_policy" "ec2_read_only" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_user" "iam_admin_users_for_eks" {
  count = length(var.aws_admin_users)
  name = var.aws_admin_users[count.index]
}
resource "aws_iam_user" "iam_users_for_eks" {
  count = length(var.aws_users)
  name = var.aws_users[count.index]
}

resource "aws_iam_user_policy_attachment" "iam_admin_manage_own_creds_attachment" {
  count      = length(var.aws_admin_users)
  user       = aws_iam_user.iam_admin_users_for_eks[count.index].name
  policy_arn = data.aws_iam_policy.iam_manage_own_creds.arn
}
resource "aws_iam_user_policy_attachment" "iam_manage_own_creds_attachment" {
  count      = length(var.aws_users)
  user       = aws_iam_user.iam_users_for_eks[count.index].name
  policy_arn = data.aws_iam_policy.iam_manage_own_creds.arn
}
resource "aws_iam_user_policy_attachment" "iam_admin_manage_own_keys_attachment" {
  count      = length(var.aws_admin_users)
  user       = aws_iam_user.iam_admin_users_for_eks[count.index].name
  policy_arn = aws_iam_policy.iam_manage_own_keys.arn
}
resource "aws_iam_user_policy_attachment" "iam_manage_own_keys_attachment" {
  count      = length(var.aws_users)
  user       = aws_iam_user.iam_users_for_eks[count.index].name
  policy_arn = aws_iam_policy.iam_manage_own_keys.arn
}
resource "aws_iam_user_policy_attachment" "ec2_read_only_attachment" {
  count      = length(var.aws_users)
  user       = aws_iam_user.iam_users_for_eks[count.index].name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}
resource "aws_iam_user_policy_attachment" "eks_read_only_attachment" {
  count      = length(var.aws_users)
  user       = aws_iam_user.iam_users_for_eks[count.index].name
  policy_arn = aws_iam_policy.eks_read_only.arn
}

data "aws_iam_policy_document" "iam_manage_own_keys_document" {
  statement {
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:GetAccessKeyLastUsed",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey"
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
}

resource "aws_iam_policy" "iam_manage_own_keys" {
  name   = "iam_manage_own_keys"
  policy = data.aws_iam_policy_document.iam_manage_own_keys_document.json
}

data "aws_iam_policy_document" "eks_read_only_document" {
  statement {
    actions = [
      "eks:ListNodegroups",
      "eks:DescribeFargateProfile",
      "eks:ListTagsForResource",
      "eks:ListAddons",
      "eks:DescribeAddon",
      "eks:ListFargateProfiles",
      "eks:DescribeNodegroup",
      "eks:ListUpdates",
      "eks:DescribeUpdate",
      "eks:AccessKubernetesApi",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:DescribeAddonVersions",
      "eks:ListIdentityProviderConfigs",
      "iam:ListRoles"
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "eks_read_only" {
  name   = "eks_read_only"
  policy = data.aws_iam_policy_document.eks_read_only_document.json
}
