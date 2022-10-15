terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.37.0"
    }
  }
}

provider "tfe" {
  # Configuration options
}

data "tfe_organization" "sic-mundus" {
  name = var.tfe_org
}