/**
* Deploys IAM resources for external-dns
*/

terraform {
  required_version = ">= 1.0.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.48.0"
    }

  }
}

locals {
  iam_role_name = var.iam_role_name == "" ? null : var.iam_role_name
}

module "assume_role_policy" {
  source                = "andreswebs/eks-irsa-policy-document/aws"
  version               = "1.0.0"
  cluster_oidc_provider = var.cluster_oidc_provider
  k8s_sa_name           = var.k8s_sa_name
  k8s_sa_namespace      = var.k8s_namespace
}

resource "aws_iam_role" "this" {
  name                  = local.iam_role_name
  assume_role_policy    = module.assume_role_policy.json
  force_detach_policies = true
}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = "ChangeRecords"
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:${data.aws_partition.current.partition}:route53:::hostedzone/${var.route53_zone_id}"]
  }

  statement {
    sid = "List"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]
    resources = ["*"] # tfsec:ignore:aws-iam-no-policy-wildcards
  }
}


resource "aws_iam_role_policy" "this" {
  name   = "external-dns-permissions"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.this.json
}
