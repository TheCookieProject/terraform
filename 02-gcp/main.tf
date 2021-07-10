## Configure the Google Cloud provider
provider "google" {
  credentials = var.credentials_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

## Network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
## Virtual Machines
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-01"
  machine_type = var.machine_type

boot_disk {
  initialize_params {
  image = var.image
  }
}

network_interface {
  network = google_compute_network.vpc_network.self_link
  access_config {
  }
}
}