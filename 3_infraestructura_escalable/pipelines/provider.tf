terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }
  }
}

terraform {
  cloud {
    organization = "sic-mundus"

    workspaces {
      name = "pipelines-DevOpsDays"
    }
  }
}

provider "google" {
  credentials = ".creds"
  region      = var.region
  project = "days-devops"
}

provider "google-beta" {
  credentials = ".creds"
  region = var.region
  project = "days-devops"
}
