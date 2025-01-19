terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.6.0"
    }
  }
}

provider "vault" {
  address = var.vault_server_address
  token   = var.vault_server1_rtoken
}