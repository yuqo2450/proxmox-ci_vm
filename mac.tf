resource "macaddress" "vm_base_macaddress" {
  count = length(var.interfaces)

  prefix = var.mac_prefix
}
