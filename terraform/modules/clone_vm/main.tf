data "vsphere_datacenter" "dc" {
  name = "Phoenix"
}

resource "time_sleep" "wait_10_seconds" {
  destroy_duration = "10s"
}

resource "vsphere_folder" "folder" {
  count         = var.create_vm_folder ? 1 : 0
  path          = var.vm_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
  lifecycle {
    create_before_destroy = false
  }
  depends_on = [time_sleep.wait_10_seconds]
}

data "vsphere_network" "portgroups" {
  for_each      = var.networks
  name          = each.value.portgroup
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "compute_cluster" {
  name          = var.compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count            = var.number_of_instances
  name             = var.number_of_instances > 1 ? format("${var.vm_name_prefix}-%02d", count.index + 1) : var.vm_name_prefix
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  dynamic "network_interface" {
    for_each = data.vsphere_network.portgroups
    content {
      network_id   = network_interface.value.id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }
  }

  dynamic "disk" {
    for_each = var.disks
    content {
      label          = disk.value.label
      size           = disk.value.size
      keep_on_remove = disk.value.keep_on_remove
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    # For whatever reason the customization always fails with network
    # started in disconnected mode.
    # So, we do not perform any customization to the clonedVM here.
    # This should be handled in provisioning
  }

  lifecycle {
    create_before_destroy = false
  }
  depends_on = [
    vsphere_folder.folder
  ]

}
