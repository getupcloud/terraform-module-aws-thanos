variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}
variable "customer_name" {
  description = "customer name"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "URL of the OIDC Provider from the EKS cluster"
  type        = string
}

variable "service_account_namespace" {
  description = "Namespace of ServiceAccount for cluster-autoscaler controller"
  default     = "velero"
}

variable "service_account_name" {
  description = "ServiceAccount name for cluster-autoscaler controller"
  default     = "eks-infra-velero"
}
variable "tags" {
  description = "AWS tags to apply to resources"
  type        = any
  default     = {}
}