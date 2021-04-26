## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "random_id" "tag" {
  byte_length = 2
}

data "oci_identity_region_subscriptions" "test_region_subscriptions" {
    tenancy_id = var.tenancy_ocid
}

resource "oci_identity_tag_namespace" "ArchitectureCenterTagNamespace" {
    provider = oci.homeregion
    compartment_id = var.compartment_ocid
    description = "ArchitectureCenterTagNamespace"
    name = "ArchitectureCenter\\data-science-oci-${random_id.tag.hex}"

    provisioner "local-exec" {
       command = "sleep 10"
    }
}

resource "oci_identity_tag" "ArchitectureCenterTag" {
    provider = oci.homeregion
    description = "ArchitectureCenterTag"
    name = "release"
    tag_namespace_id = oci_identity_tag_namespace.ArchitectureCenterTagNamespace.id

    validator {
        validator_type = "ENUM"
        values         = ["release", "1.1"]
    }

    provisioner "local-exec" {
       command = "sleep 120"
    }

}