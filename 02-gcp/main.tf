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

## Firewall
resource "google_compute_firewall" "default" {
  name    = "fw-services"
  network = google_compute_network.vpc_network.self_link
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["fw-services"]
}

## Virtual Machines
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-01"
  machine_type = var.machine_type
  tags         = ["fw-services"]

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