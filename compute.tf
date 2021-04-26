
## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create Compute Instances

resource "oci_core_instance" "compute_instance1" {
  availability_domain = var.availablity_domain_name
  count               = "3"
  compartment_id      = var.compartment_ocid
  display_name        = "App-Server-${(count.index%3)+1}"
  shape               = var.instance_shape

  dynamic "shape_config" {
    for_each = local.is_flexible_node_shape ? [1] : []
    content {
      memory_in_gbs = var.instance_shape_flex_memory
      ocpus = var.instance_shape_flex_ocpus
    }
  }
  
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
    ssh_authorized_keys = var.ssh_public_key
    user_data = data.template_cloudinit_config.cloud_init.rendered
  }

  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

  timeouts {
    create = "60m"
  }
}
