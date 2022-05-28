module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v2.64.0"

  name            = var.name
  cidr            = var.vpc_cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # base
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  # subnets
  map_public_ip_on_launch = var.map_public_ip_on_launch
  private_subnet_tags     = merge(var.private_subnet_tags, var.tags)
  public_subnet_tags      = merge(var.public_subnet_tags, var.tags)

  # default sg
  manage_default_security_group  = var.manage_default_security_group
  default_security_group_egress  = var.default_security_group_egress
  default_security_group_ingress = var.default_security_group_ingress

  # NAT
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  # flow logs
  enable_flow_log           = var.enable_flow_log
  flow_log_destination_type = var.flow_log_destination_type
  flow_log_destination_arn  = var.flow_log_destination_arn

  # tags
  tags = var.tags
}