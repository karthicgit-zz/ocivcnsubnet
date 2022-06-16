output "subnet_id" {
  value = { for v in oci_core_subnet.vcn_subnet : v.display_name => v.id }
}

output "all_attributes" {
  value = { for k, v in oci_core_subnet.vcn_subnet : k => v }
}
