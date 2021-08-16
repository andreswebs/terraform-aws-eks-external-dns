output "namespace" {
  value       = local.k8s_namespace
  description = "The name (`metadata.name`) of the Kubernetes namespace"
}
