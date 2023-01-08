variable "name" {
  type        = string
  description = "The name of the virtual machine."
}
variable "id" {
  type        = number
  description = "VM ID to be used."
  default     = null
}
variable "node_name" {
  type        = string
  description = "Name of the node to deploy vm to."
}
variable "template" {
  type        = string
  description = "Name of the vm or template to clone."
}
variable "cpu_cores" {
  type    = number
  default = 4
}
variable "cpu_vcpu" {
  type    = number
  default = 2
}
variable "mem_size" {
  type    = number
  default = 1024
}
variable "disks" {
  type = list(object(
    {
      disk_datastore = string
      disk_size      = string
    }
  ))
  default = [
    {
      disk_datastore = "local-zfs"
      disk_size      = "10G"
    }
  ]
}
variable "interfaces" {
  type = map(map(string))
  description = <<EOT
    Map of strings for network interfaces.
    !Required keys for each interface are net_bridge and net_vlan!
    MAC address is automatically merged into this map with the mac_address key.
    These values are also accessible in your netdata template using the interfaces key.
  EOT
}
variable "description" {
  type        = string
  default     = "cloud-init vm"
  description = "Short text to give overview of the vm usage."
}
variable "userdata_template" {
  type        = string
  description = "Path to cloud init user-data template file on local filesystem."
}
variable "netdata_template" {
  type        = string
  description = "Path to cloud init network-data template file on local filesystem."
}
variable "userdata_vars" {
  type        = any
  description = "Host specific userdata data values (hostname)."
}
variable "netdata_vars" {
  type        = any
  default     = null
  description = "Host specific userdata data values (hostname)."
}
variable "mac_prefix" {
  type        = list(number)
  default     = [100, 179, 121]
  description = "MAC address prefix for interfaces."
}
