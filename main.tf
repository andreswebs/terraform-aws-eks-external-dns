/**
* Deploys external-dns on AWS EKS.
*/

terraform {
  required_version = ">= 1.0.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.48.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.3"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }

  }
}

module "iam" {
  source                = "./modules/iam"
  cluster_oidc_provider = var.cluster_oidc_provider
  k8s_namespace         = var.k8s_namespace
  k8s_sa_name           = var.k8s_sa_name
  iam_role_name         = var.iam_role_name
}

module "resources" {
  source                  = "./modules/resources"
  create_namespace        = var.create_namespace
  k8s_namespace           = var.k8s_namespace
  k8s_sa_name             = var.k8s_sa_name
  iam_role_arn            = module.iam.role.arn
  external_dns_image_name = var.external_dns_image_name
  external_dns_image_tag  = var.external_dns_image_tag
  txt_owner_id            = var.txt_owner_id
}
