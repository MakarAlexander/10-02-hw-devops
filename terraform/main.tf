
module "node-exporter" {
  source             = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id         = module.vpc_prod.network.id
  subnet_zones       = [var.node-exporter_params.zone]
  subnet_ids         = [module.vpc_prod.subnet[var.node-exporter_params.zone].id]
  instance_name      = var.node-exporter_params.instance_name
  instance_count     = var.node-exporter_params.count
  instance_cores     = var.node-exporter_params.instance_cores
  instance_memory    = var.node-exporter_params.instance_memory
  boot_disk_size     = var.node-exporter_params.boot_disk_size
  image_family       = var.node-exporter_params.image_family
  public_ip          = var.node-exporter_params.public_ip

  metadata = {
    user-data          = data.template_file.web_cloudinit.rendered
    serial-port-enable = 1
  }
}

module "prometheus" {
  source             = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id         = module.vpc_prod.network.id
  subnet_zones       = [var.prometheus_params.zone]
  subnet_ids         = [module.vpc_prod.subnet[var.prometheus_params.zone].id]
  instance_name      = var.prometheus_params.instance_name
  instance_count     = var.prometheus_params.count
  instance_cores     = var.prometheus_params.instance_cores
  instance_memory    = var.prometheus_params.instance_memory
  boot_disk_size     = var.prometheus_params.boot_disk_size
  image_family       = var.prometheus_params.image_family
  public_ip          = var.prometheus_params.public_ip

  metadata = {
    user-data          = data.template_file.web_cloudinit.rendered
    serial-port-enable = 1
  }
}

module "grafana" {
  source             = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id         = module.vpc_prod.network.id
  subnet_zones       = [var.grafana_params.zone]
  subnet_ids         = [module.vpc_prod.subnet[var.grafana_params.zone].id]
  instance_name      = var.grafana_params.instance_name
  instance_count     = var.grafana_params.count
  instance_cores     = var.grafana_params.instance_cores
  instance_memory    = var.grafana_params.instance_memory
  boot_disk_size     = var.grafana_params.boot_disk_size
  image_family       = var.grafana_params.image_family
  public_ip          = var.grafana_params.public_ip

  metadata = {
    user-data          = data.template_file.web_cloudinit.rendered
    serial-port-enable = 1
  }
}

data "template_file" "web_cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
    packages       = jsonencode(var.packages)
  }
}