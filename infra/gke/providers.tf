terraform {
  required_version = ">= 1.3" # Specify a minimum Terraform version

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.3.0" 
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Provider for enabling necessary Google Cloud services
provider "google-beta" {
  project = var.project_id
  region  = var.region
}
