## Configure the Google Cloud provider
provider "google" {
  credentials = var.credentials_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

## Network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network-vpc"
}

resource "google_compute_subnetwork" "vpc_network" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "terraform-network-internal"
  subnetwork   = google_compute_subnetwork.vpc_network.id
  address_type = "INTERNAL"
  address      = "10.0.0.2"
  region       = var.region
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

# resource "google_compute_disk" "default" {
#   name  = "terraform-01-test"
#   type  = "pd-ssd"
#   zone  = var.zone
#   image = var.image
#   labels = {
#     environment = "dev"
#   }
#   physical_block_size_bytes = 4096
# }

# resource "google_compute_attached_disk" "default" {
#   disk     = google_compute_disk.default.id
#   instance = google_compute_instance.vm_instance.id
# }

## Firewall
resource "google_compute_firewall" "default" {
  name    = "fw-services"
  network = google_compute_network.vpc_network.self_link
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "80" ,"443"]
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
  type  = "pd-ssd"
  image = var.image
  size = 20
  }
}

# attached_disk {
#   source      = google_compute_disk.default.id
#   device_name = "terraform-01-disk"
# }

network_interface {
  network = google_compute_network.vpc_network.self_link
  access_config {
    nat_ip = google_compute_address.static.address
  }
}
}