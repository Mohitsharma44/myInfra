[VMs]
%{ for vm in vms ~}
${vm.fqdn} ansible_host=${vm.ip}
%{ endfor ~}