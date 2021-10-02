resource "digitalocean_droplet" "www" {
    image = "centos-7-x64"
    name = "www-1"
    region = "nyc1"
    size = "s-1vcpu-2gb"
    private_networking = true
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
}

output "ip_host" {
  value = digitalocean_droplet.www.ipv4_address
}
