data "aws_iam_policy" "iam_manage_own_creds" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
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
