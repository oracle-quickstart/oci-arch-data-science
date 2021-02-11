# oci-arch-data-science

Oracle Machine Learning is embedded in both Oracle Autonomous Data Warehouse and Oracle Autonomous Transaction Processing. Because the machine learning algorithms are resident in the database, data scientists can avoid the time, effort, and expense of moving the data to external systems for analysis and model building, scoring, and deployment.

For details of the architecture, see [_Set up a data science environment that uses Oracle Machine Learning_](https://docs.oracle.com/en/solutions/data-science-environment/index.html)

## Prerequisites

- Permission to `manage` the following types of resources in your Oracle Cloud Infrastructure tenancy: `vcns`, `internet-gateways`, `route-tables`, `security-lists`, `subnets`, `autonomous-database-family`, and `instances`.

- Quota to create the following resources: 1 VCN, 1 subnet, 1 Internet Gateway, 1 route rules, 1 DRG, 1 ADW database instance, 1 DataCatalog instance, 1 Oracle Analytics Cloud (OAC) instance, and 3 compute instances (User Application VMs).

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

## Deploy Using Oracle Resource Manager

1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-quickstart/oci-arch-data-science/releases/latest/download/oci-arch-data-science-stack-latest.zip)

    If you aren't already signed in, when prompted, enter the tenancy and user credentials.

2. Review and accept the terms and conditions.

3. Select the region where you want to deploy the stack.

4. Follow the on-screen prompts and instructions to create the stack.

5. After creating the stack, click **Terraform Actions**, and select **Plan**.

6. Wait for the job to be completed, and review the plan.

    To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.

7. If no further changes are necessary, return to the Stack Details page, click **Terraform Actions**, and select **Apply**. 

## Deploy Using the Terraform CLI

### Clone the Module
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-quickstart/oci-arch-data-science
    cd oci-arch-data-science
    ls

### Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Availablity Domain 
availablity_domain_name = "<availablity_domain_name>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"

# Autonomous Data Warehouse
autonomous_database_admin_password = "<enter-password-here>"

# Oracle Analytics Cloud
analytics_instance_capacity_capacity_type = "<enter_capacity_type_here>"
analytics_instance_capacity_capacity_value = "<enter_capacity_value_here>"
analytics_instance_feature_set = "<enter_feature_set_here>"
analytics_instance_license_type = "<enter_license_type_here>"
analytics_instance_name = "<enter_OAC_instance_name_here>"
analytics_instance_idcs_access_token = "<insert_user_IDCS_token_here>"

````

### Create the Resources
Run the following commands:

    terraform init
    terraform plan
    terraform apply

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy

## Architecture Diagram

![](./images/adb-ml.PNG)

