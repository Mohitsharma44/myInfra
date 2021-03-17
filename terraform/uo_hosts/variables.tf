variable "vm_template_name" {
  description = "Name of the vm template to use for cloning"
  type        = string
  default     = "ubuntu-2004-template"
}

variable "vm_group" {
  description = "Group name for the VMs. This will be added to ansible hosts file"
  type        = string
  default     = ""
}

variable "vm_folder" {
  description = "Name of vSphere folder to add VM to"
  type        = string
}

variable "vm_name_prefix" {
  description = "Prefix for the name of the VM"
  type        = string
}

variable "number_of_instances" {
  description = "Number of instances to spin up"
  type        = number
  default     = 1
}

variable "cpus" {
  description = "Number of CPUs"
  type        = number
}

variable "memory" {
  description = "RAM size in MB"
  type        = number
}

variable "networks" {
  description = "Map of networks to attach to the VM"
  type        = map(map(string))
}

variable "datastore" {
  description = "Datastore to create the VM's VMDK file in"
  type        = string
}

variable "disks" {
  description = "Map of disks to attach to the guest VM"
  type        = map(map(string))
}

