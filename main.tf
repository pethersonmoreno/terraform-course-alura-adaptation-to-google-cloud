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
    # A default network is created for all GCP projects
    network = "default"
    access_config {
     // Include this section to give the VM an external ip address
    }
  }
}

output "ip" {
 value = google_compute_instance.dev.network_interface.0.access_config.0.nat_ip
}