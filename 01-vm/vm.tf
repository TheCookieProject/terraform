resource "digitalocean_volume" "kvolume" {
  region                  = "nyc1"
  name                    = "kvol"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "an example volume"
}

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

resource "digitalocean_volume_attachment" "volume" {
  droplet_id = digitalocean_droplet.www.id
  volume_id  = digitalocean_volume.kvolume.id
}
