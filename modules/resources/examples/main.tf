module "external_dns_resources" {
  source                     = "github.com/andreswebs/terraform-aws-eks-external-dns//modules/resources"
  iam_role_arn               = var.external_dns_iam_role_arn
  route53_txt_owner_zone_id  = var.external_dns_txt_owner_zone_id
}