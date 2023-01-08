
locals {
  interfaces = length(var.interfaces) == length(var.ip4_addresses) ? { for k, v in var.interfaces : k => merge(v, { "mac_address" = macaddress.vm_base_macaddress[regex("\\d", k)].address, "ip4_address" = var.ip4_addresses[k] }) } : { for k, v in var.interfaces : k => merge(v, { "mac_address" = macaddress.vm_base_macaddress[regex("\\d", k)].address }) }
  userdata   = merge(var.userdata_vars, { "hostname" = var.name })
  netdata    = merge(var.netdata_vars, { "interfaces" = local.interfaces })
}
