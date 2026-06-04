resource "google_compute_instance" "air_traffic_controller" {
  name         = "air-traffic-controller"
  machine_type = "n4a-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.project_wide_subnet.self_link
  }

  service_account {
    email  = google_service_account.air_traffic_controller.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    if [ -f /etc/initialized ]; then
      git -C /root/claude-playground pull
      exit 0
    fi

    apt-get update && apt-get install -y git
    git config --global user.email "robot.tim@${var.gcp_domain}"

    mkdir -p /root/.ssh
    gcloud secrets versions access latest --secret="git-bootstrapping-key" > /root/.ssh/git-bootstrapping-key
    chmod 600 /root/.ssh/git-bootstrapping-key
    printf 'Host github.com\n  IdentityFile /root/.ssh/git-bootstrapping-key\n  StrictHostKeyChecking no\n' > /root/.ssh/config

    git clone git@github.com:robottim-kroppel/claude-playground.git /root/claude-playground

    bash /root/claude-playground/initialize-air-traffic-controller.sh

    touch /etc/initialized
  EOT
}
