# OCI VCN with Internet Gateway and Public Subnet Terraform Deployment via OCI Resource Manager

## Overview
This Terraform configuration deploys a Virtual Cloud Network (VCN) with an Internet Gateway and a public subnet in Oracle Cloud Infrastructure (OCI). The deployment is intended to be executed using **OCI Resource Manager**.

## Prerequisites
- An OCI tenancy with proper permissions to create networking resources.
- Access to OCI Console with permissions to create and manage Resource Manager stacks.
- Terraform configuration files (`main.tf` and `variables.tf`) packaged as a ZIP archive.

## Deployment Steps

1. **Prepare your Terraform Zip Archive**
   - Package `main.tf` and `variables.tf` into a single ZIP file (e.g., `oci-vcn-deployment.zip`).

2. **Upload the ZIP Archive to OCI Resource Manager**
   - Go to OCI Console → Developer Services → Resource Manager.
   - Create a new Stack and upload the ZIP file.

3. **Set Input Variables**
   - In the Stack details, navigate to **Variables**.
   - Set values for required input variables such as:
     - `compartment_id`: OCID of the compartment where resources will be deployed.
     - `vcn_cidr`: CIDR block for the VCN (e.g., `10.0.0.0/16`).
     - `public_subnet_cidr`: CIDR block for the public subnet (e.g., `10.0.1.0/24`).

4. **Create a Terraform Plan**
   - Use Resource Manager to create a Terraform plan to validate the deployment.

5. **Apply the Terraform Plan**
   - Apply the plan to provision the resources.

6. **Monitor Stack Activity**
   - Monitor logs and events from the Resource Manager Console to track progress.

## Variables

| Name               | Description                       | Type   | Required/Default      |
|--------------------|---------------------------------|--------|----------------------|
| `compartment_id`    | OCI Compartment OCID             | string | *Required*           |
| `vcn_cidr`          | CIDR block for the VCN           | string | "10.0.0.0/16" (default) |
| `public_subnet_cidr`| CIDR block for the public subnet | string | "10.0.1.0/24" (default) |

## Outputs

Outputs will be visible in the Resource Manager stack outputs once the apply completes, including:

- VCN OCID
- Internet Gateway OCID
- Public Subnet OCID

## Notes

- No local Terraform installation is needed.
- All Terraform executions happen inside OCI.
- Ensure that your OCI user has sufficient policies to create networking resources.
- To update the stack, upload a new version of the ZIP archive and create a new plan and apply.

---

