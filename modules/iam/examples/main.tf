module "external_dns_iam" {
  source                = "github.com/andreswebs/terraform-aws-eks-external-dns//modules/iam"
  cluster_oidc_provider = var.eks_cluster_oidc_provider
  iam_role_name         = "external-dns-${var.eks_cluster_id}"
}