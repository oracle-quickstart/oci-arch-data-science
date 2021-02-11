resource "oci_identity_tag_namespace" "ArchitectureCenterTagNamespace" {
    compartment_id = var.compartment_ocid
    description = "ArchitectureCenterTagNamespace"
    name = "ArchitectureCenter\\data-science-oci"
  
    # Required for longop of tag deletion in background (approximately 20 minutes)
    provisioner "local-exec" {
       when    = destroy
       command = "sleep 1200"
    }

    provisioner "local-exec" {
       command = "sleep 10"
    }
}

resource "oci_identity_tag" "ArchitectureCenterTag" {
    description = "ArchitectureCenterTag"
    name = "release"
    tag_namespace_id = oci_identity_tag_namespace.ArchitectureCenterTagNamespace.id

    validator {
        validator_type = "ENUM"
        values         = ["release", "1.0"]
    }

    provisioner "local-exec" {
       command = "sleep 20"
    }

}