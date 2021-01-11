module "ansiblevault" {
  source                       = "../modules/ansible_vault"
  ansible_vault_encrypted_file = "inventories/group_vars/all.yml"
  ansible_vault_password_file  = "/Users/mohitsharma44/devel/myInfra/phoenixDC/.vmware_inventory_password"
  root_folder                  = "/Users/mohitsharma44/devel/myInfra/phoenixDC/"
}

provider "vsphere" {
  user                 = module.ansiblevault.vcenter_user
  password             = module.ansiblevault.vcenter_pass
  vsphere_server       = module.ansiblevault.vcenter_fqdn
  allow_unverified_ssl = false
}
