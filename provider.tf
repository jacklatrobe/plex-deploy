###########################################################
## DevOps Workspace Environment                          ##
## By Jack Latrobe - Head of DevOps @ Swoop Analytics    ##
## https://latrobe.group/       jack@jack-latrobe.com    ##
###########################################################
## File: provider.tf                                     ##
## Purpose: Sets up the digital ocean TF provider        ##
########################################################### 

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}