module "create_vm" {
  source              = "../modules/clone_vm"
  number_of_instances = var.number_of_instances
  vm_folder           = var.vm_folder
  vm_name_prefix      = var.vm_name_prefix
  cpus                = var.cpus
  memory              = var.memory
  networks            = var.networks
  disks               = var.disks
  datastore           = var.datastore
}

locals {
  vms = [for host, ip in module.create_vm.vm_info : {
    fqdn = "${host}.phoenixdc.sharmamohit.com",
    ip   = ip
    }
  ]
}

# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  filename = "../../inventories/tfhosts"
  content = templatefile("./templates/hosts.tpl",
    {
      vms = local.vms
    }
  )
}

resource "null_resource" "provision_vm" {
  provisioner "local-exec" {
    command = <<EOT
    cd ../../ && \
    ansible-playbook -i inventories/tfhosts --limit '${join(",", [for vm in local.vms : vm.fqdn])},' playbooks/create_vm/provision.yml
    EOT
  }
}
