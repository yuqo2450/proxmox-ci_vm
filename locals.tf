
locals {
  interfaces = { for k, v in var.interfaces : k => merge(v, { "mac_address" = macaddress.vm_base_macaddress[regex("\\d", k)].address }) }
  userdata   = merge(var.userdata_vars, { "hostname" = var.name })
  netdata    = merge(var.netdata_vars, { "interfaces" = local.interfaces })
  startup    = var.startup != null ? join(",", [for key, value in var.startup : "${key}=${value}" if value != null]) : null
}
