## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# This Terraform script provisions a OAC instance

# Create DataCatlaog Instance

resource "oci_datacatalog_catalog" "test_catalog" {
    #Required
    compartment_id = "${var.compartment_ocid}"

    #Optional
#defined_tags = {"foo-namespace.bar-key"= "value"}
display_name = "test_catalog_instance"
#freeform_tags = {"bar-key"= "value"}
}
