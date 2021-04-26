## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create VCN

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "app-db-vcn2"
  dns_label      = "tfexamplevcn2"
  defined_tags   = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

data "oci_core_services" "test_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

resource "oci_core_internet_gateway" "ExampleIG" {
  compartment_id = var.compartment_ocid
  display_name   = "TFExampleIG"
  vcn_id         = oci_core_virtual_network.vcn.id
  defined_tags   = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Create route table to associate with app server subnet

resource "oci_core_route_table" "apprt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "app-rt-table"
  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.ExampleIG.id
  }
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Create regional subnets in vcn

resource "oci_core_subnet" "subnet_1" {
  cidr_block        = "10.0.0.0/24"
  display_name      = "app-subnet"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  dhcp_options_id   = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id    = oci_core_route_table.apprt.id
  prohibit_public_ip_on_vnic = false
  dns_label         = "subnet1"
  defined_tags      = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_drg" "test_drg" {
    compartment_id = var.compartment_ocid
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_drg_attachment" "test_drg_attachment" {
    drg_id = oci_core_drg.test_drg.id
    vcn_id = oci_core_virtual_network.vcn.id
}


