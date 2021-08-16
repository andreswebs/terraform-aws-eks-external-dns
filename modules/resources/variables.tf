variable "k8s_sa_name" {
  type        = string
  description = "Name of the Kubernetes service account"
  default     = "external-dns"
}

variable "k8s_namespace" {
  type        = string
  description = "Name of the Kubernetes namespace"
  default     = "external-dns"
}

variable "create_namespace" {
  type        = bool
  description = "Create the Kubernetes namespace?"
  default     = true
}

variable "external_dns_image_name" {
  type = string
  description = "The full path to the external-dns container image, in the format `<registry>/<image>`"
  default = "k8s.gcr.io/external-dns/external-dns"
}

variable "external_dns_image_tag" {
  type = string
  description = "The external-dns image tag"
  default = "v0.9.0"
}

variable "iam_role_arn" {
  type = string
  description = "IAM role ARN used by the Kubernetes service account"
}

variable "route53_txt_owner_zone_id" {
  type = string
  description = "ID of the Route53 hosted zone where TXT records for external-dns will be kept"
}