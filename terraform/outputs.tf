resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
  {
    vm_public_ips: { 
      node-exporter: module.node_exporter_vm.vm_ips[0].public_ip
      grafana: module.grafana_vm.vm_ips[0].public_ip,
      prometheus: module.prometheus_vm.vm_ips[0].public_ip
    }
  })

  filename = "${abspath(path.module)}/../ansible/hosts.yml"
}