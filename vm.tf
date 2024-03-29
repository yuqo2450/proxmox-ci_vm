resource "proxmox_vm_qemu" "vm_base" {

  provider = telmate-proxmox

  name        = var.name
  desc        = var.description
  vmid        = var.id
  target_node = var.node_name
  clone       = var.template
  agent       = 1
  os_type     = "cloud-init"
  onboot      = var.onboot
  startup     = var.startup != null ? local.startup : null
  cores       = var.cpu_cores
  sockets     = 1
  vcpus       = var.cpu_vcpu
  numa        = true
  cpu         = "x86-64-v2-AES"
  memory      = var.mem_size
  balloon     = 1024
  hotplug     = "network,disk,usb,memory,cpu"
  qemu_os     = "l26"
  scsihw      = "virtio-scsi-pci"
  dynamic "disk" {
    for_each = var.disks[*]
    content {
      size    = disk.value.disk_size
      format  = "raw"
      type    = "scsi"
      storage = disk.value.disk_datastore
      ssd     = disk.value.ssd != null ? disk.value.ssd : 0
    }
  }
  bootdisk = "scsi0"
  dynamic "network" {
    for_each = local.interfaces
    iterator = interface
    content {
      model   = "e1000"
      bridge  = interface.value.net_bridge
      tag     = tonumber(interface.value.net_vlan)
      macaddr = interface.value.mac_address
    }
  }
  cicustom = "user=${proxmox_virtual_environment_file.vm_base_userdata.id},network=${proxmox_virtual_environment_file.vm_base_netdata.id}"
}
