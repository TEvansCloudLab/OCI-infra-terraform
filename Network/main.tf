terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "oci" {
  region = var.region
}

# Create VCN
resource "oci_core_vcn" "vcn" {
  cidr_block     = var.vcn_cidr
  display_name   = "dev-vcn"
  compartment_id = var.compartment_ocid
}

# Create Internet Gateway
resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.compartment_ocid
  display_name   = "dev-internet-gw"
  vcn_id         = oci_core_vcn.vcn.id
}

# Create Route Table
resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "dev-route-table"

  route_rules {
    network_entity_id = oci_core_internet_gateway.ig.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

# Create Public Subnet
resource "oci_core_subnet" "subnet" {
  cidr_block              = var.subnet_cidr
  display_name            = "dev-public-subnet"
  compartment_id          = var.compartment_ocid
  vcn_id                  = oci_core_vcn.vcn.id
  route_table_id          = oci_core_route_table.rt.id
  prohibit_public_ip_on_vnic = false
}

