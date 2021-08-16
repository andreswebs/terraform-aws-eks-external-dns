/**
* Deploys Kubernetes resources for external-dns
*/

terraform {
  required_version = ">= 1.0.0"

  required_providers {

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


## namespace

locals {
  k8s_namespace_norm = var.k8s_namespace == "" || var.k8s_namespace == null ? "external-dns" : var.k8s_namespace
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name        = local.k8s_namespace_norm
    labels      = var.k8s_namespace_labels
    annotations = var.k8s_namespace_annotations
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
      metadata[0].annotations,
    ]
  }

}

locals {
  k8s_namespace = var.create_namespace ? kubernetes_namespace.this[0].metadata[0].name : local.k8s_namespace_norm
}

resource "null_resource" "k8s_namespace" {
  triggers = {
    "name" = local.k8s_namespace
  }
}


data "kubectl_file_documents" "this" {
  depends_on = [null_resource.k8s_namespace]
  content = templatefile("${path.module}/k8s/external-dns.yml.tpl", {
    image_name = var.external_dns_image_name
    image_tag = var.external_dns_image_tag
    k8s_namespace = local.k8s_namespace
    k8s_sa_name = var.k8s_sa_name
    iam_role_arn = var.iam_role_arn
    txt_owner_id = var.route53_txt_owner_zone_id
  })
}

resource "kubectl_manifest" "this" {
  count     = length(data.kubectl_file_documents.this.documents)
  yaml_body = element(data.kubectl_file_documents.this.documents, count.index)
}
