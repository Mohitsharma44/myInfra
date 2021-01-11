data "ansiblevault_path" "esxi_fqdn" {
  path = var.ansible_vault_encrypted_file
  key = "esxi_fqdn"
}

data "ansiblevault_path" "esxi_pass" {
  path = var.ansible_vault_encrypted_file
  key = "esxi_pass"
}

data "ansiblevault_path" "esxi_user" {
  path = var.ansible_vault_encrypted_file
  key = "esxi_user"
}

data "ansiblevault_path" "vcenter_fqdn" {
  path = var.ansible_vault_encrypted_file
  key = "vcenter_fqdn"
}

data "ansiblevault_path" "vcenter_pass" {
  path = var.ansible_vault_encrypted_file
  key = "vcenter_pass"
}

data "ansiblevault_path" "vcenter_user" {
  path = var.ansible_vault_encrypted_file
  key = "vcenter_user"
}