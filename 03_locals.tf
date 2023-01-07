
locals {
  interfaces = length(var.vm_interfaces) == length(var.ip4_addresses) ? { for k, v in var.vm_interfaces : k => merge(v, { "mac_address" = macaddress.vm_base_macaddress[regex("\\d", k)].address, "ip4_address" = var.ip4_addresses[k] }) } : { for k, v in var.vm_interfaces : k => merge(v, { "mac_address" = macaddress.vm_base_macaddress[regex("\\d", k)].address }) }
  userdata   = merge(var.userdata_vars, { "hostname" = var.vm_name })
  netdata    = merge(var.netdata_vars, { "interfaces" = local.interfaces })
}
