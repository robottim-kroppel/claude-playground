terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-backend"
    prefix = "air-traffic-controller"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "apis" {
  for_each = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
    "secretmanager.googleapis.com",
  ])
  project = var.project_id
  service = each.key
}

resource "google_service_account" "air_traffic_controller" {
  account_id   = var.service_account_id
  display_name = "Air Traffic Controller VM"
}

resource "google_project_iam_member" "secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.air_traffic_controller.email}"
}

resource "google_secret_manager_secret" "git_bootstrapping_key" {
  secret_id = "git-bootstrapping-key"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "git_bootstrapping_key" {
  secret      = google_secret_manager_secret.git_bootstrapping_key.id
  secret_data = "fake"
}
