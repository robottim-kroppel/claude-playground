variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "service_account_id" {
  description = "Service account ID for the VM"
  type        = string
}

variable "gcp_domain" {
  description = "GCP domain (e.g. kroppel.net)"
  type        = string
  default     = "kroppel.net"
}
