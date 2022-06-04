###########################################################
## DevOps Workspace Environment                          ##
## By Jack Latrobe - Head of DevOps @ Swoop Analytics    ##
## https://latrobe.group/       jack@jack-latrobe.com    ##
###########################################################
## File: project.tf                                      ##
## Purpose: Adds deployed infra to a DO project          ##
########################################################### 

# Create a project
resource "digitalocean_project" "plex_project" {
  name        = "Plex Server"
  description = "A personal workspace for running a plex server"
  purpose     = "Plex"
  environment = "Production"
  resources   = [
      digitalocean_droplet.plex1.urn,
      digitalocean_volume.plex_vol.urn]
}