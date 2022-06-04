###########################################################
## DevOps Workspace Environment                          ##
## By Jack Latrobe - Head of DevOps @ Swoop Analytics    ##
## https://latrobe.group/       jack@jack-latrobe.com    ##
###########################################################
## File: ssh.tf                                          ##
## Purpose: Manages my SSH keys in digital ocean         ##
########################################################### 

#Upload the SSH public key to DO
resource "digitalocean_ssh_key" "default" {
  name       = "MainKeyTF"
  public_key = file("./ssh/id_rsa.pub")
}