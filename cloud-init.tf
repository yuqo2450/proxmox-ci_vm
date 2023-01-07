
locals {
  interfaces = length(var.vm_interfaces) == length(var.ip4_addresses) ? {for k, v in var.vm_interfaces : k => merge(v, {"mac_address" = macaddress.vm_base_macaddress[regex("\\d",k)].address, "ip4_address" = var.ip4_addresses[k]})} : {for k, v in var.vm_interfaces : k => merge(v, {"mac_address" = macaddress.vm_base_macaddress[regex("\\d",k)].address})}
  userdata = merge(var.userdata_vars, {"hostname" = var.vm_name})
}
resource "proxmox_virtual_environment_file" "vm_base_userdata" {
  
  provider      = bpg-proxmox

  content_type  = "snippets"
  datastore_id  = "local"
  node_name     = var.node_name
  source_raw {
    data      = templatefile(var.userdata_template, local.userdata)
    file_name = "${var.vm_name}-user.yaml"
  }
}
resource "proxmox_virtual_environment_file" "vm_base_netdata" {
  
  provider      = bpg-proxmox

  content_type  = "snippets"
  datastore_id  = "local"
  node_name     = var.node_name
  source_raw {
    data      = templatefile(var.netdata_template, {
        "interfaces" = local.interfaces
        "nameservers" = var.nameserver_vars
      }
    )
    file_name = "${var.vm_name}-net.yaml"
  }
}
