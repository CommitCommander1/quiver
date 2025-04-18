
resource "google_container_cluster" "primary_cluster" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.region 

  # We are creating the node pool separately, so remove the default one
  remove_default_node_pool = true
  initial_node_count       = 1 

  network    = google_compute_network.gke_vpc.id
  subnetwork = google_compute_subnetwork.gke_subnet.id

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.gke_subnet.secondary_ip_range[0].range_name # pods-range
    services_secondary_range_name = google_compute_subnetwork.gke_subnet.secondary_ip_range[1].range_name # services-range
  }

  # Configure control plane authorized networks (optional but recommended for security)
  # Allows access to the control plane only from specified CIDR blocks
  # master_authorized_networks_config {
  #   cidr_blocks {
  #     cidr_block   = var.home_ip 
  #     display_name = "Home Network"
  #   }
  # }

  # Configure control plane networking (can use default or specify)
  private_cluster_config {
    enable_private_endpoint = false # Keep public endpoint for easier access initially
    # enable_private_nodes    = true # Set to true for private nodes (no external IPs) - requires Cloud NAT for egress
    master_ipv4_cidr_block  = var.gke_master_ip_cidr_range
  }

  # Recommended settings
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"] # Enable basic system monitoring
  }
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"] # Enable system and workload logging
  }

  # Enable features like workload identity (recommended for secure access to GCP services)
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Ensure network and APIs are ready before creating cluster
  depends_on = [
    google_compute_network.gke_vpc,
    google_compute_subnetwork.gke_subnet,
    google_project_service.container
  ]

  # Avoid issues where destroying the network before the cluster causes errors
  lifecycle {
    prevent_destroy = false 
  }
}
