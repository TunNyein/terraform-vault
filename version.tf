terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.6.0"
    }
  }
}

provider "vault" {
  address = "http://192.168.57.10:8100"
  token   = var.vault_server1_rtoken
}