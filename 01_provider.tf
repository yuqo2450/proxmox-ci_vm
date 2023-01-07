terraform {
  ### Add required providers here.
  required_providers {
    telmate-proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.7.1"
    }
    bpg-proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.4.4"
    }
    macaddress = {
      source  = "ivoronin/macaddress"
      version = ">= 0.3.0"
    }
  }
}
