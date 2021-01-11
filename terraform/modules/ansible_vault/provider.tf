provider "ansiblevault" {
  vault_path  = var.ansible_vault_password_file
  root_folder = var.root_folder
}
