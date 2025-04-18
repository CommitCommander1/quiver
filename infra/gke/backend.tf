terraform {
  backend "gcs" {
    bucket = "quiver-state"
    prefix = "gke/state"
  }
}
