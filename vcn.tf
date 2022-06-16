module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.4.0"

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

  # vcn parameters
  create_internet_gateway       = var.create_internet_gateway
  create_nat_gateway            = var.create_nat_gateway
  create_service_gateway        = var.create_service_gateway
  internet_gateway_display_name = var.internet_gateway_display_name
  nat_gateway_display_name      = var.nat_gateway_display_name
  service_gateway_display_name  = var.service_gateway_display_name
  create_drg                    = var.create_drg
  drg_display_name              = var.drg_display_name
  freeform_tags                 = var.freeform_tags
  vcn_cidrs                     = var.vcn_cidrs
  vcn_dns_label                 = var.vcn_dns_label
  vcn_name                      = var.vcn_name
  lockdown_default_seclist      = var.lockdown_default_seclist

}

#Module for Subnet
module "subnet" {
  source = "./modules/subnet"

  compartment_id = var.compartment_id
  subnets        = var.subnets
  #enable_ipv6    = var.enable_ipv6
  vcn_id       = module.vcn.vcn_id
  ig_route_id  = var.create_internet_gateway ? module.vcn.ig_route_id : null
  nat_route_id = var.create_nat_gateway ? module.vcn.nat_route_id : null

  count = length(var.subnets) > 0 ? 1 : 0

}
