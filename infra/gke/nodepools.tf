
resource "google_container_node_pool" "primary_nodes" {
  project    = var.project_id
  name       = var.primary_node_pool_name
  location   = var.region
  cluster    = google_container_cluster.primary_cluster.name
  node_count = 1 

  autoscaling {
    min_node_count = var.primary_node_pool_min_nodes
    max_node_count = var.primary_node_pool_max_nodes
  }

  management {
    auto_repair  = true # Enable automatic node repair
    auto_upgrade = true # Enable automatic node upgrades
  }

  node_config {
    machine_type = var.primary_node_pool_machine_type
    disk_size_gb = var.primary_node_pool_disk_size_gb
    disk_type    = "pd-standard" # Standard persistent disk

    metadata = {
      disable-legacy-endpoints = "true"
    }

    # Using default GKE service account initially, can be customized for least privilege
    # service_account = "kubernetes-service-account@${var.project_id}.iam.gserviceaccount.com"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform" # Broad scope, refine if needed
    ]

    # Use Workload Identity
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    spot = true
  }

  depends_on = [
    google_container_cluster.primary_cluster
  ]
}
