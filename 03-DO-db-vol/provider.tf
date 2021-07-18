terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

data "digitalocean_ssh_key" "terraform" {
  name = "${var.pvt_key}"
}
