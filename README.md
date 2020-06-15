# oci-arch-adb-ml

The architecture uses a region with one availability domain and regional subnets. You can use the same architecture in a region that has multiple availability domains.

## Terraform Provider for Oracle Cloud Infrastructure
The OCI Terraform Provider is now available for automatic download through the Terraform Provider Registry. 
For more information on how to get started view the [documentation](https://www.terraform.io/docs/providers/oci/index.html) 
and [setup guide](https://www.terraform.io/docs/providers/oci/guides/version-3-upgrade.html).

* [Documentation](https://www.terraform.io/docs/providers/oci/index.html)
* [OCI forums](https://cloudcustomerconnect.oracle.com/resources/9c8fa8f96f/summary)
* [Github issues](https://github.com/terraform-providers/terraform-provider-oci/issues)
* [Troubleshooting](https://www.terraform.io/docs/providers/oci/guides/guides/troubleshooting.html)

Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-quickstart/oci-arch-hub-spoke.git
    cd oci-arch-hub-spoke
    ls

## Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# SSH Keys
ssh_public_key  = "<public_ssh_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"


# Autonomous Data Warehouse
autonomous_database_admin_password="<Password>"

# Oracle Analytics Cloud
analytics_instance_capacity_capacity_type="OLPU_COUNT"
analytics_instance_capacity_capacity_value="1"
analytics_instance_feature_set="ENTERPRISE_ANALYTICS"
analytics_instance_license_type="LICENSE_INCLUDED"
analytics_instance_name="<instance_name>"
analytics_instance_idcs_access_token="<idcs_token>"

````

Deploy:

    terraform init
    terraform plan
    terraform apply

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy

## adb-ml Architecture

![](./images/adb-ml.PNG)

## Reference Archirecture

- [Setup a adb-ml network topology](https://docs.oracle.com/en/solutions/data-science-environment/index.html)
