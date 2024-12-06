module "vpc_prod" {
  source  = "../terraform/vpc"
  name    = var.prod_env.vpc_name
  subnets = var.prod_env.subnets
}
