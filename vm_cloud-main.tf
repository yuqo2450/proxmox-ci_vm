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
      source = "ivoronin/macaddress"
      version = ">= 0.3.0"
    }
  }
}

### Add values u want to reuse in this file. Or shorten expressions.
locals {
  networks = [for k, v in var.vm_networks : merge(v, {"mac_address" = macaddress.vm_macaddress[k].address})]
  userdata = proxmox_virtual_environment_file.vm_userdata.id
  netdata = proxmox_virtual_environment_file.vm_netdata.id
}

### Add resources in this section.
resource "macaddress" "vm_macaddress" {
  count = length(var.vm_networks)
}

resource "proxmox_virtual_environment_file" "vm_userdata" {
  
  provider      = bpg-proxmox

  content_type  = "snippets"
  datastore_id  = "local"
  node_name     = var.node_name

  source_raw {
    data      = templatefile(var.userdata_template, var.userdata_vars)
    file_name = "${var.vm_name}-user.yaml"
  }
}

resource "proxmox_virtual_environment_file" "vm_netdata" {
  
  provider      = bpg-proxmox

  content_type  = "snippets"
  datastore_id  = "local"
  node_name     = var.node_name

  source_raw {
    data      = templatefile(var.netdata_template, tomap(local.networks))
    file_name = "${var.vm_name}-net.yaml"
  }
}

resource "proxmox_vm_qemu" "vm" {

  provider          = telmate-proxmox

  name              = var.vm_name
  desc              = var.description
  vmid              = var.vm_id

  target_node       = var.node_name
  clone             = var.template
  agent             = 1

  os_type           = "cloud-init"
  cores             = var.cpu_cores
  sockets           = 1
  vcpus             = var.cpu_vcpu
  numa              = true
  cpu               = "qemu64"
  memory            = var.mem_size
  balloon           = 512
  hotplug           = "network,disk,usb,memory,cpu"
  qemu_os           = "l26"
  scsihw            = "virtio-scsi-pci"

  dynamic "disk" {
    for_each        = var.vm_disks[*]
    content {
      size          = disk.value.disk_size
      type          = "scsi"
      storage       = disk.value.disk_datastore
    }
  }

  bootdisk          = "scsi0"

  dynamic "network" {
    for_each        = local.networks[*]
    content {
      model         = "e1000"
      bridge        = network.value.net_bridge
      tag           = network.value.net_vlan
      macaddr       = network.value.mac_address
    }
  }

  cicustom          = "user=${local.userdata},network=${local.netdata}"
}