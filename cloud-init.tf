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
    data      = templatefile(var.netdata_template, local.netdata)
    file_name = "${var.vm_name}-net.yaml"
  }
}
