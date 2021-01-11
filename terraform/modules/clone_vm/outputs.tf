output "dc_name" {
  value = data.vsphere_datacenter.dc.name
}

output "datastore_id" {
  value = data.vsphere_datastore.datastore.id
}

output "compute_cluster" {
  value = data.vsphere_compute_cluster.compute_cluster.name
}

output "fqdns" {
  value = vsphere_virtual_machine.vm.*.name
}

output "vm_info" {
  value = zipmap(
    vsphere_virtual_machine.vm.*.name,
    vsphere_virtual_machine.vm.*.default_ip_address,
  )
}

output "all_ips" {
  value = zipmap(
    vsphere_virtual_machine.vm.*.name,
    vsphere_virtual_machine.vm.*.guest_ip_addresses
  )
}