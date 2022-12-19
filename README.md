---
title: Azure Linux VM using Terraform
description: Create Azure Linux VM using Terraform
---

# Step-00: Introduction
We are going to create following Azure Resources
1. azurerm_public_ip
2. azurerm_network_interface
3. azurerm_network_security_group
4. azurerm_network_interface_security_group_association
5. Terraform Local Block for Security Rule Ports
6. Terraform `for_each` Meta-argument
7. azurerm_network_security_rule
8. Terraform Local Block for defining custom data to Azure Linux Virtual Machine
9. azurerm_linux_virtual_machine
10. Terraform Outputs
11. Terraform Functions
- [file](https://www.terraform.io/docs/language/functions/file.html)
- [filebase64](https://www.terraform.io/docs/language/functions/filebase64.html)
- [base64encode](https://www.terraform.io/docs/language/functions/base64encode.html)

# Pre-requisite Note: Create SSH Keys for Azure Linux VM
```t
# Create Folder
mkdir ssh-keys

# Create SSH Key, Do not give a passphrase
cd ssh-keys
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@myserver" \
    -f terraform-azure.pem

# List Files
ls -lrt ssh-keys/

# Files Generated after above command
Public Key: terraform-azure.pem.pub -> Rename as terraform-azure.pub with mv terraform-azure.pem.pub terraform-azure.pub
Private Key: terraform-azure.pem

# Permissions for Pem file
chmod 400 terraform-azure.pem
```

# Step-01: Providers
Create `providers.tf` file and fill it.

# Step 02: Variables
Create `variables.tf` file and put these variables in it:
- Business Division in the large organization this Infrastructure belongs
- Environment Variable used as a prefix
- Resource Group Name
- Region in which Azure Resources to be created

# Step 03: Locals
Create `locals.tf` file and fill it in.

# Step 04: Random resources
Create `random-resources.tf` file and create myrandom resource.

# Step 05: Resource group
Create `resource-groups.tf` file and the resource group

# Step 06: VNet, subnet, and NSG
Create files for
- VNet variables `vnet-variables.tf`
- VNet `virtual-network.tf`
- Subnet and NSG `subnet-and-nsg.tf`
- VNet outputs `vnet-outputs.tf`

# Step 07: Provision and configure the Linux VM
## Step-07-01: Linux VM input variables
Create `linuxvm-variables.tf` file for Linux VM input variables.

## Step-07-02: Linux VM public IP
Create `linuxvm-publicip.tf` file for Linux VM public IP.

## Step-07-03: Linux VM NIC
Create `linuxvm-network-interface.tf` for Linux VM NIC.

## [Optional] Step-07-04: Linux VM NSG
Create `linuxvm-network-security-group.tf` for Linux VM NSG.

## Step-07-05: Linux VM
- We have two options to define `custom_data` to Azure Linux VM
	- **Option-1:** Using file as input (shell script file or `cloud-init.txt` file)
	- **Option-2:** Define the code in Terraform locals block
- We will review both options and choose `Option-2` for implementation.
- Commented code will be available in `azurerm_linux_virtual_machine` to use `option-1` too.
Create `linuxvm.tf` file and fill it in.

## Step-07-06: Linux VM outputs
Create `linuxvm-outputs.tf` file.

# Step-08: terraform.tfvars
Create the `terraform.tfvars` file and fill it with preferred values.

# Step-09: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
```

# Step-10: Verify Resources
```t
# Verify Resources - Virtual Network
1. Azure Resource Group
2. Azure Virtual Network
3. Azure Subnet
4. Azure Network Security Group
5. View the topology
6. Verify Terraform Outputs in Terraform CLI

# Verify Resources - Web Linux VM
1. Verify Public IP created for Linux VM
2. Verify Network Interface created for Linux VM
3. Verify Linux VM
4. Verify Network Security Groups associated with VM (Subnet NSG and NIC NSG)
5. View Topology at Linux VM -> Networking
6. Connect to Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<LinuxVM-PublicIP>
sudo su -
cd /var/log
tail -100f cloud-init-output.log
cd /var/www/html
ls -lrt
cd /var/www/html/app1
ls -lrt
exit
exit

7. Access Sample Application
http://<PUBLIC-IP>/
http://<PUBLIC-IP>/app1/index.html
http://<PUBLIC-IP>/app1/hostname.html
http://<PUBLIC-IP>/app1/status.html
http://<PUBLIC-IP>/app1/metadata.html
```

# Step-11: Comment NSG associated with VM
```t
# Comment code in `linuxvm-network-security-group.tf`
NSG associated with Linux VM NIC is commented

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify NSG associated with VM
1. Verify Network Security Groups associated with VM (subnet NSG only)
2. Access Application
http://<PUBLIC-IP>/app1/metadata.html
```

# Step-12: Delete Resources
```t
# Delete Resources
terraform destroy
[or]
terraform apply -destroy -auto-approve

# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```