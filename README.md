# terraform-aws-eks-external-dns

[//]: # (BEGIN_TF_DOCS)
Deploys external-dns on AWS EKS.

## Usage

Example:

```hcl
module "external_dns" {
  source                    = "github.com/andreswebs/terraform-aws-eks-external-dns"
  cluster_oidc_provider     = var.eks_cluster_oidc_provider
  iam_role_name             = "external-dns-${var.eks_cluster_id}"
  route53_txt_owner_zone_id = var.external_dns_txt_owner_zone_id
}
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_oidc_provider"></a> [cluster\_oidc\_provider](#input\_cluster\_oidc\_provider) | OpenID Connect (OIDC) Identity Provider associated with the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the Kubernetes namespace? | `bool` | `true` | no |
| <a name="input_external_dns_image_name"></a> [external\_dns\_image\_name](#input\_external\_dns\_image\_name) | The full path to the container image, in the format `<registry>/<image>` | `string` | `"k8s.gcr.io/external-dns/external-dns"` | no |
| <a name="input_external_dns_image_tag"></a> [external\_dns\_image\_tag](#input\_external\_dns\_image\_tag) | The image tag | `string` | `"v0.9.0"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the IAM role used by the Kubernetes service account | `string` | `"external-dns"` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | Name of the Kubernetes namespace | `string` | `"external-dns"` | no |
| <a name="input_k8s_sa_name"></a> [k8s\_sa\_name](#input\_k8s\_sa\_name) | Name of the Kubernetes service account | `string` | `"external-dns"` | no |
| <a name="input_route53_txt_owner_zone_id"></a> [route53\_txt\_owner\_zone\_id](#input\_route53\_txt\_owner\_zone\_id) | ID of the Route53 hosted zone where TXT records for external-dns will be kept | `string` | n/a | yes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_resources"></a> [resources](#module\_resources) | ./modules/resources | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The name (`metadata.name`) of the Kubernetes namespace |
| <a name="output_role"></a> [role](#output\_role) | IAM role for the Kubernetes service account |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.48.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.11.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.4.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |

## Resources

No resources.

[//]: # (END_TF_DOCS)

## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE.md).
