# meta
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# iam admin role assume policy
data "aws_iam_policy_document" "my_admin_assume_role_policy" {
  statement {
    sid = "allowAssumeRole"

    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/sally"]
      type        = "AWS"
    }
  }
}

# iam admin (assume) role
resource "aws_iam_role" "my_admin" {
  name               = "my-admin-role"
  assume_role_policy = data.aws_iam_policy_document.my_admin_assume_role_policy.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  tags = merge(local.tags, {
    Name = "my-admin-role"
  })
}