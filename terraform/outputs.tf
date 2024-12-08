resource "local_file" "inventory" {
  content = templatefile(
    "${path.module}/inventory.tftpl", {
      node-exporter = { for i, v in module.node-exporter.external_ip_address : module.node-exporter.fqdn[i] => v }
      prometheus    = { for i, v in module.prometheus.external_ip_address : module.prometheus.fqdn[i] => v }
      grafana       = { for i, v in module.grafana.external_ip_address : module.grafana.fqdn[i] => v }
    }
  )
  filename = "../ansible/hosts.yml"
}