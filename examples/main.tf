module "external_dns" {
  source                = "github.com/andreswebs/terraform-aws-eks-external-dns"
  cluster_oidc_provider = var.eks_cluster_oidc_provider
  iam_role_name         = "external-dns-${var.eks_cluster_id}"
  route53_zone_id       = var.route53_zone_id
  txt_owner_id          = var.eks_cluster_id
}