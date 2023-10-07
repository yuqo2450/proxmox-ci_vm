terraform {
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

provider "telmate-proxmox" {

  pm_api_url      = "https://example.com:8006/api2/json"
  pm_user         = "root@pam"
  pm_tls_insecure = false
}

provider "bpg-proxmox" {
  endpoint = "https://example.com:8006"
  insecure = false
  username = "root@pam"
}

module "example" {
  source = "git@github.com:yuqo2450/tf_pmx_vm_base.git"
  providers = {
    telmate-proxmox = telmate-proxmox
    bpg-proxmox     = bpg-proxmox
  }
  name              = "example"
  node_name         = "nodename"
  template          = "example-template"
  userdata_template = "/path/to/userdata-template.yaml"
  netdata_template  = "/path/to/netdata-template.yaml"

  interfaces = {
    "eth0" = {
      net_bridge  = "vmbr0"
      net_vlan    = 0
    }
  }
}
