output "esxi_fqdn" {
  value = data.ansiblevault_path.esxi_fqdn.value
}

output "esxi_pass" {
  value = data.ansiblevault_path.esxi_pass.value
  sensitive = true
}

output "esxi_user" {
  value = data.ansiblevault_path.esxi_user.value
}

output "vcenter_fqdn" {
  value = data.ansiblevault_path.vcenter_fqdn.value
}

output "vcenter_pass" {
  value = data.ansiblevault_path.vcenter_pass.value
  sensitive = true
}

output "vcenter_user" {
  value = data.ansiblevault_path.vcenter_user.value
}