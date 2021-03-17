variable "compute_cluster" {
  description = "VSphere cluster to create new VM in"
  type        = string
  default     = "Cluster01"
}

variable "number_of_instances" {
  description = "Number of instances to spin up"
  type        = number
  default     = 1
}

variable "vm_template_name" {
  description = "Name of the vm template to use for cloning"
  type        = string
  default     = "ubuntu-2004-template"
}

variable "vm_folder" {
  description = "Name of vSphere folder to add VM to"
  type        = string
}

variable "create_vm_folder" {
  description = "Whether to create vm folder or not"
  type        = bool
  default     = true
}

variable "vm_name_prefix" {
  description = "Prefix for the name of the VM"
  type        = string
}

variable "cpus" {
  description = "Number of CPUs"
  type        = number
  default     = 2
}

variable "memory" {
  description = "RAM size in MB"
  type        = number
  default     = 2048
}

variable "networks" {
  description = "Map of networks to attach to the VM"
  type        = map(map(string))
  default = {
    lan = {
      dvswitch  = "DLanSwitch0",
      portgroup = "DLanSwitchPortGroup0",
    },
    storage = {
      dvswitch  = "DStorageSwitch",
      portgroup = "DStoragePortGroup",
    }
  }
}

variable "datastore" {
  description = "Datastore to create the VM's VMDK file in"
  type        = string
  default     = "Silo"
}

variable "disks" {
  description = "Map of disks to attach to the guest VM"
  type        = map(map(string))
  default = {
    disk0 = {
      label          = "disk0",
      size           = 60,
      keep_on_remove = false,
    },
  }
}

