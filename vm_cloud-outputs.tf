output "vm_default_ip" {
  value = proxmox_vm_qemu.vm_cloud.default_ipv4_address
  description = "Returns default IP address of created vm."
}