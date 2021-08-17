# terraform-aws-eks-external-dns resources

[//]: # (BEGIN_TF_DOCS)
Deploys Kubernetes resources for external-dns

## Usage

Example:

```hcl
module "external_dns_resources" {
  source       = "github.com/andreswebs/terraform-aws-eks-external-dns//modules/resources"
  iam_role_arn = var.external_dns_iam_role_arn
  txt_owner_id = var.eks_cluster_id
}
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the Kubernetes namespace? | `bool` | `false` | no |
| <a name="input_external_dns_image_name"></a> [external\_dns\_image\_name](#input\_external\_dns\_image\_name) | The full path to the external-dns container image, in the format `<registry>/<image>` | `string` | `"k8s.gcr.io/external-dns/external-dns"` | no |
| <a name="input_external_dns_image_tag"></a> [external\_dns\_image\_tag](#input\_external\_dns\_image\_tag) | The external-dns image tag | `string` | `"v0.9.0"` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | IAM role ARN used by the Kubernetes service account | `string` | n/a | yes |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | Name of the Kubernetes namespace | `string` | `"external-dns"` | no |
| <a name="input_k8s_sa_name"></a> [k8s\_sa\_name](#input\_k8s\_sa\_name) | Name of the Kubernetes service account | `string` | `"external-dns"` | no |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | Route53 zone ID on which external-dns is allowed to create resources | `string` | `"*"` | no |
| <a name="input_txt_owner_id"></a> [txt\_owner\_id](#input\_txt\_owner\_id) | (Optional) A string used to identify the current external-dns instance in TXT records; defaults to a random string | `string` | `""` | no |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The name (`metadata.name`) of the Kubernetes namespace |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.11.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.4.1 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.11.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.4.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.this](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [null_resource.k8s_namespace](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.txt_owner](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [kubectl_file_documents.this](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

[//]: # (END_TF_DOCS)
