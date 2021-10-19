locals {
  name_prefix = substr("${var.cluster_name}-thanos", 0, 32)
}

data "aws_iam_policy_document" "aws_thanos" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.customer_name}-eks-thanos",
      "arn:aws:s3:::${var.customer_name}-eks-thanos/*"
    ]
  }
}

resource "aws_iam_policy" "aws_thanos" {
  name        = local.name_prefix
  description = "thanos policy for EKS cluster ${var.cluster_name}"
  policy      = data.aws_iam_policy_document.aws_thanos.json
}


module "irsa_aws_thanos" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "~> 4.2"

  create_role                   = true
  role_name                     = local.name_prefix
  provider_url                  = var.cluster_oidc_issuer_url
  role_policy_arns              = [aws_iam_policy.aws_thanos.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.service_account_namespace}:${var.service_account_name}"]
}

resource "aws_s3_bucket" "aws_thanos" {
  bucket = "${var.customer_name}-eks-thanos"
  acl    = "private"

  tags = merge({
    Name = "${var.cluster_name}"
    }, var.tags
  )
}