terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }
  }
}

provider "google" {
  project = "days-devops"
  region  = var.region
}

provider "google-beta" {
  project = "days-devops"
  region  = var.region
}
