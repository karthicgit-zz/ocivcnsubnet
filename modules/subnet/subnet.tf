locals {
  dhcp_default_options = data.oci_core_dhcp_options.dhcp_options.options.0.id
}

resource "oci_core_subnet" "vcn_subnet" {
  for_each       = var.subnets
  cidr_block     = each.value.cidr
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id


  defined_tags    = var.defined_tags
  dhcp_options_id = local.dhcp_default_options
  display_name    = lookup(each.value, "name", each.key)
  dns_label       = lookup(each.value, "dns_label", null)
  freeform_tags   = var.freeform_tags

  prohibit_public_ip_on_vnic = lookup(each.value, "type", "public") == "public" ? false : true
  route_table_id             = lookup(each.value, "type", "public") == "public" ? var.ig_route_id : var.nat_route_id
  security_list_ids          = null
}

data "oci_core_dhcp_options" "dhcp_options" {

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
}
