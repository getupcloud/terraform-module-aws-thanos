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
  description = "Namespace of ServiceAccount for thanos"
  default     = "monitoring"
}

variable "service_account_name" {
  description = "ServiceAccount name for thanos"
  default     = "eks-infra-thanos"
}
variable "tags" {
  description = "AWS tags to apply to resources"
  type        = any
  default     = {}
}
