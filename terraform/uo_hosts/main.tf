module "create_vm" {
  source              = "../modules/clone_vm"
  number_of_instances = var.number_of_instances
  vm_folder           = var.vm_folder
  vm_template_name    = var.vm_template_name
  create_vm_folder    = false
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
  filename = "../../ansible/inventories/${var.vm_folder}"
  content = templatefile("./templates/hosts.tpl",
    {
      vm_group = var.vm_name_prefix,
      vms      = local.vms
    }
  )
}

resource "null_resource" "provision_vm" {
  //  triggers = {
  //    #always_run = "${timestamp()}"
  //    md5 = "${filemd5(join("/", ["../../ansible/inventories", var.vm_folder]))}"
  //  }
  provisioner "local-exec" {
    command = <<EOT
    cd ../../ansible && \
    ANSIBLE_FORCE_COLOR=1 ansible-playbook -i 'inventories/${var.vm_folder}' --limit '${join(",", [for vm in local.vms : vm.fqdn])},' playbooks/create_vm/provision.yml
    EOT
  }
  depends_on = [local_file.hosts_cfg]
}
