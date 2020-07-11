provider "google" {
  version     = "3.29.0"
  credentials = file("~/.terraform-configs/terraform-pet.json")
  project     = "terraform-pet"
  region      = "us-east1"
  zone        = "us-east1-c"
}

resource "google_compute_instance" "dev" {
  name         = "terraform-google-dev0"
  machine_type = "f1-micro" # 1 CPU and 614 MB memory
  zone         = "us-east1-c"

  tags = ["terraform", "dev0"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20200701"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  network_interface {
    # network = "default"
    network = google_compute_network.default.name
    access_config {
     // Include this section to give the VM an external ip address
    }
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name
  # network = "default"

  direction = "INGRESS"

  source_ranges = ["187.57.0.19/32"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_network" "default" {
  name  = "default-terraform-pet"
  project = "terraform-pet"
  routing_mode  = "REGIONAL"
  description = "Default network for the project terraform-pet"
  timeouts {}
}

output "ip" {
 value = google_compute_instance.dev.network_interface.0.access_config.0.nat_ip
}