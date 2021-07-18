resource "digitalocean_volume" "kvolume" {
  region                  = "nyc1"
  name                    = "kvol"
  size                    = 20
  initial_filesystem_type = "ext4"
  description             = "an example volume"
}

resource "digitalocean_droplet" "idb" {
    image = "centos-7-x64"
    name = "idb-1"
    region = "nyc1"
    size = "s-1vcpu-2gb"
    private_networking = true
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
}

resource "digitalocean_volume_attachment" "volume" {
  droplet_id = digitalocean_droplet.idb.id
  volume_id  = digitalocean_volume.kvolume.id
}

output "ip_host" {
  value = digitalocean_droplet.idb.ipv4_address
}
