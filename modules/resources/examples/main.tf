module "external_dns_resources" {
  source       = "github.com/andreswebs/terraform-aws-eks-external-dns//modules/resources"
  iam_role_arn = var.external_dns_iam_role_arn
  txt_owner_id = var.eks_cluster_id
}