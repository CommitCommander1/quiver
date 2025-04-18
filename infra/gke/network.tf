
resource "google_project_service" "compute" {
  provider = google-beta # Use beta provider if necessary for specific features
  project  = var.project_id
  service  = "compute.googleapis.com"

  # Don't disable the API when destroying infrastructure
  disable_on_destroy = false
}

resource "google_project_service" "container" {
  provider = google-beta
  project  = var.project_id
  service  = "container.googleapis.com"

  disable_on_destroy = false
}


# Create the VPC network
resource "google_compute_network" "gke_vpc" {
  project                 = var.project_id
  name                    = var.gke_network_name
  auto_create_subnetworks = false # We will create a custom subnet
  routing_mode            = "REGIONAL"
  depends_on = [
    google_project_service.compute # Ensure Compute API is enabled first
  ]
}

resource "google_compute_subnetwork" "gke_subnet" {
  project                  = var.project_id
  name                     = var.gke_subnet_name
  ip_cidr_range            = var.gke_subnet_ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.gke_vpc.id
  private_ip_google_access = true # Allows nodes to reach Google APIs without external IPs

  # Define secondary IP ranges for GKE pods and services
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.20.0.0/16" # Example - Adjust if needed
  }
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.30.0.0/16" # Example - Adjust if needed
  }
}
