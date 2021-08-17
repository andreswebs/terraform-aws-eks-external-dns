module "external_dns" {
  source                    = "github.com/andreswebs/terraform-aws-eks-external-dns"
  cluster_oidc_provider     = var.eks_cluster_oidc_provider
  iam_role_name             = "external-dns-${var.eks_cluster_id}"
  route53_txt_owner_zone_id = var.external_dns_txt_owner_zone_id
}