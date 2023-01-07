resource "macaddress" "vm_base_macaddress" {
  count = length(var.vm_interfaces)
}
