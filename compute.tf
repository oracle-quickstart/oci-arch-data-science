
## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create Compute Instances

resource "oci_core_instance" "compute_instance1" {
  availability_domain = var.availablity_domain_name
  count               = "3"
  compartment_id      = var.compartment_ocid
  display_name        = "App-Server-${(count.index%3)+1}"
  shape               = var.instance_shape
  fault_domain        = "FAULT-DOMAIN-${(count.index%3)+1}"

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet_1.id
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

  timeouts {
    create = "60m"
  }
}
