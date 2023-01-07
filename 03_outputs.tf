output "vm" {
  value = proxmox_vm_qemu.vm_base.default_ipv4_address
  description = "Returns default IP address of created vm."
}