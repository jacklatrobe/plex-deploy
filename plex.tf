###########################################################
## Plex Server Environment                               ##
## By Jack Latrobee                                      ##
## https://latrobe.group/       jack@jack-latrobe.com    ##
###########################################################
## File: main.tf                                         ##
## Purpose: Provisions infra for plex and flexget        ##
########################################################### 

# Create plex storage volume
resource "digitalocean_volume" "plex_vol" {
  region                  = var.region
  name                    = "plex-vol"
  size                    = 250
  initial_filesystem_type = "ext4"
  initial_filesystem_label = "plexvol"
  description             = "Plex media volume"

  tags = var.tags
}

# Create a ubuntu plex server
resource "digitalocean_droplet" "plex1" {
  image  = "ubuntu-20-04-x64"
  name   = "plex1"
  region = var.region
  size   = "c-2"
  backups = true
  monitoring = true
  ipv6 = true

  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

  tags = var.tags
}

# Attach volume to the droplet
resource "digitalocean_volume_attachment" "foobar" {
  droplet_id = digitalocean_droplet.plex1.id
  volume_id  = digitalocean_volume.plex_vol.id
}

# Assign a floating IP to the droplet
resource "digitalocean_floating_ip" "plex_ip" {
  droplet_id = digitalocean_droplet.plex1.id
  region     = digitalocean_droplet.plex1.region
}

# Add a firewall to the plex server
resource "digitalocean_firewall" "plex-firewall" {
  name = "plex-firewall"

  droplet_ids = [digitalocean_droplet.plex1.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  tags = var.tags
}