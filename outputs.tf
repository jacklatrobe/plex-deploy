###########################################################
## DevOps Workspace Environment                          ##
## By Jack Latrobe - Head of DevOps @ Swoop Analytics    ##
## https://latrobe.group/       jack@jack-latrobe.com    ##
###########################################################
## File: outputs.tf                                      ##
## Purpose: Sets up outputs from provisioning script     ##
########################################################### 


# Return the public IP address of the DevOps VM / gateway
output "plex_ip_addr" {
  value = digitalocean_floating_ip.plex_ip.ip_address
}