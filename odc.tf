## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# This Terraform script provisions a OAC instance

# Create DataCatlaog Instance

resource "oci_datacatalog_catalog" "test_catalog" {
  compartment_id = var.compartment_ocid
  display_name = var.catalog_display_name
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
