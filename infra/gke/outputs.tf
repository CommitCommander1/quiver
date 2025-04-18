
output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary_cluster.name
}

output "cluster_endpoint" {
  description = "The public endpoint of the GKE cluster control plane."
  value       = google_container_cluster.primary_cluster.endpoint
  sensitive   = true # Endpoint might be considered sensitive
}

output "cluster_location" {
  description = "The location (region) of the GKE cluster."
  value       = google_container_cluster.primary_cluster.location
}

output "primary_node_pool_name" {
  description = "The name of the primary node pool."
  value       = google_container_node_pool.primary_nodes.name
}

output "kubeconfig_command" {
  description = "Command to configure kubectl for the created cluster."
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary_cluster.name} --region ${var.region} --project ${var.project_id}"
}
