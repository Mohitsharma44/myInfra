variable "ansible_vault_password_file" {
  type        = string
  description = "path to the password of the vault encrypted file"
}

variable "root_folder" {
  type        = string
  description = "root folder from where one can run `ansible-vault decrypt` from"
}

variable "ansible_vault_encrypted_file" {
  type        = string
  description = "path to the vault encrypted file relative to `root_folder`"
}
