# Define input variables for the Terraform configuration

variable "project_id" {
  description = "The Google Cloud project ID to deploy resources into."
  type        = string
  # No default - force user to provide via .tfvars or environment variable
}

variable "region" {
  description = "The Google Cloud region to deploy resources into."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "quiver-v1"
}

variable "gke_network_name" {
  description = "The name for the VPC network for GKE."
  type        = string
  default     = "gke-vpc"
}

variable "gke_subnet_name" {
  description = "The name for the subnet within the GKE VPC."
  type        = string
  default     = "gke-subnet"
}

variable "gke_subnet_ip_cidr_range" {
  description = "The IP address range for the GKE subnet."
  type        = string
  default     = "10.10.0.0/20"
}

variable "gke_master_ip_cidr_range" {
  description = "The IP address range for the GKE control plane."
  type        = string
  default     = "172.16.0.0/28"
}

variable "primary_node_pool_name" {
  description = "Name for the primary node pool."
  type        = string
  default     = "primary-pool"
}

variable "primary_node_pool_machine_type" {
  description = "Machine type for the primary node pool"
  type        = string
  default     = "e2-medium"
}

variable "primary_node_pool_min_nodes" {
  description = "Minimum number of nodes in the primary node pool."
  type        = number
  default     = 1
}

variable "primary_node_pool_max_nodes" {
  description = "Maximum number of nodes in the primary node pool (for autoscaling)."
  type        = number
  default     = 2
}

variable "primary_node_pool_disk_size_gb" {
  description = "Disk size in GB for nodes in the primary pool."
  type        = number
  default     = 30
}
variable "home_ip" {
  description = "/32 Home public Ip to give access to management plane"
  type        = string
}
