resource "google_compute_network" "project_wide_vpc" {
  name                    = "project-wide-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "project_wide_subnet" {
  name          = "project-wide-subnet"
  network       = google_compute_network.project_wide_vpc.self_link
  region        = var.region
  ip_cidr_range = "10.0.0.0/24"
}
