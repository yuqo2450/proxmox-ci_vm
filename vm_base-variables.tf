variable "vm_name" {
  type  = string
  description = "The name of the virtual machine."
}
variable "vm_id" {
  type = number
  description = "VM ID to be used."
  default = null
}
variable "node_name" {
  type  = string
  description = "Name of the node to deploy vm to."
}
variable "template" {
  type = string
  description = "Name of the vm or template to clone."
}
variable "cpu_cores" {
  type = number
  default = 4
}
variable "cpu_vcpu" {
  type = number
  default = 2
}
variable "mem_size" {
  type = number
  default = 1024
}
variable "vm_disks" {
  type = list(object(
    {
      disk_datastore = string
      disk_size = string
    }
  ))
  default = [
    {
      disk_datastore = "local-zfs"
      disk_size = "10G"
    }
  ]
}
variable "vm_interfaces" {
  type = map
  default = {
    "eth0" = {
      net_bridge = "vmbr0"
      net_vlan = -1
    }
  }
}
variable "description" {
  type = string
  default = "cloud-init vm"
  description = "Short text to give overview of the vm usage."
}
variable "userdata_template" {
  type = string
  description = "Path to cloud init user-data template file on local filesystem."
}
variable "netdata_template" {
  type = string
  description = "Path to cloud init network-data template file on local filesystem."
}
variable "userdata_vars" {
  type = any
  default = null
  description = "Host specific userdata data values (hostname)."
}