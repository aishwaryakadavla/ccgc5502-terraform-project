# CCGC 5502 – Automation with Terraform: Azure Infrastructure Project

## 1. Project Overview

This project focuses on building and managing cloud infrastructure in Microsoft Azure using Terraform.

The main goal was to create an organized, reusable, and modular infrastructure configuration. Instead of creating every Azure resource manually, I used Terraform to define the infrastructure as code. This makes it easier to deploy, manage, update, and remove resources when needed.

The project includes networking, Linux and Windows virtual machines, storage, monitoring, backup, managed disks, a load balancer, and a PostgreSQL database.

I divided the configuration into separate Terraform modules so that each part of the infrastructure has its own responsibility. The root configuration connects all the modules and manages the overall deployment.

## 2. Project Objectives

The main objectives of this project were:

- Automate Azure infrastructure deployment using Terraform.
- Use a modular structure to organize the Terraform configuration.
- Create a resource group and configure virtual networking.
- Deploy three Linux virtual machines across different availability zones.
- Deploy one Windows Server virtual machine.
- Configure network security rules and public IP addresses.
- Create and attach managed data disks to the virtual machines.
- Configure a public-facing Azure Load Balancer for the Linux virtual machines.
- Deploy an Azure Database for PostgreSQL Flexible Server.
- Configure monitoring and backup-related resources.
- Store Terraform state remotely in Azure Storage.
- Use Terraform outputs to display important infrastructure information.

## 3. Technologies and Services Used

The following technologies and Azure services were used in this project:

| Technology / Service | Purpose |
|---|---|
| Terraform | Infrastructure automation and resource management |
| Microsoft Azure | Cloud platform for hosting the infrastructure |
| Azure Resource Group | Organizes the project resources |
| Azure Virtual Network | Provides private networking |
| Network Security Group | Controls inbound network traffic |
| Azure Virtual Machines | Hosts Linux and Windows operating systems |
| Azure Availability Zones | Distributes Linux VMs across separate zones |
| Azure Availability Set | Provides availability grouping for the Windows VM |
| Azure Managed Disks | Provides additional storage for the VMs |
| Azure Load Balancer | Distributes incoming traffic across Linux VMs |
| Azure Storage Account | Stores application-related and diagnostic data |
| Log Analytics Workspace | Provides a central workspace for monitoring data |
| Recovery Services Vault | Provides a resource for backup and recovery management |
| Azure Database for PostgreSQL | Provides the managed relational database |
| GitHub | Stores and manages the Terraform project code |

## 4. Project Architecture

The infrastructure is organized into separate components, with the root Terraform configuration connecting the individual modules.

The project contains:

- One Azure resource group.
- One virtual network and subnet.
- One network security group associated with the subnet.
- Three Linux virtual machines deployed across availability zones 1, 2, and 3.
- One Windows Server 2022 virtual machine.
- Four managed data disks attached to the four virtual machines.
- One public-facing load balancer connected to the three Linux virtual machines.
- One Log Analytics workspace.
- One Recovery Services vault.
- One storage account for common infrastructure requirements.
- One Azure Database for PostgreSQL Flexible Server.

The Linux virtual machines are connected to the load balancer through their network interfaces. Each virtual machine also has its own public IP address.

The PostgreSQL server is deployed in Canada Central, while the other main project resources are deployed in East US.

## 5. Terraform Module Structure

The project uses eight child modules. Each module handles a specific part of the Azure infrastructure.

| Module | Responsibility |
|---|---|
| `rgroup-3601` | Creates the Azure resource group. |
| `network-3601` | Creates the virtual network, subnet, network security group, and security rules. |
| `common-3601` | Creates the Log Analytics workspace, Recovery Services vault, and common storage account. |
| `vmlinux-3601` | Deploys three Linux virtual machines, their network interfaces, public IPs, and Network Watcher extensions. |
| `vmwindows-3601` | Deploys the Windows Server 2022 virtual machine, availability set, networking, and Antimalware extension. |
| `datadisk-3601` | Creates four managed data disks and attaches them to the virtual machines. |
| `loadbalancer-3601` | Creates the public load balancer and connects the three Linux virtual machines to its backend pool. |
| `database-3601` | Creates the Azure Database for PostgreSQL Flexible Server. |

Each module has its own Terraform files:

- `main.tf` – Defines the resources created by the module.
- `variables.tf` – Defines the input values required by the module.
- `outputs.tf` – Returns useful information about the resources.
- `provisioner.tf` – Provides a separate location for provisioner configuration where required.

The root directory contains the main configuration files:

- `providers.tf`
- `backend.tf`
- `main.tf`
- `variables.tf`
- `outputs.tf`

This structure keeps the project organized and makes individual infrastructure components easier to understand and maintain.

## 6. Linux Virtual Machines

The project deploys three Linux virtual machines using Terraform's `for_each` feature.

The virtual machines are:

- `3601-linux-1`
- `3601-linux-2`
- `3601-linux-3`

Each Linux VM is assigned to a different Azure availability zone:

- Linux VM 1 – Zone 1
- Linux VM 2 – Zone 2
- Linux VM 3 – Zone 3

The virtual machines use the CentOS 8.2 image and Standard D2as v4 size.

Each VM has:

- Its own network interface.
- A public IP address.
- A private IP address.
- A unique DNS label.
- A Standard LRS operating system disk.
- Boot diagnostics configured through the common storage account.

The Network Watcher extension is also configured for the Linux virtual machines.

A Terraform `null_resource` with a `remote-exec` provisioner connects to each Linux VM through SSH and executes the `hostname` command. This confirms that the provisioner can connect to the virtual machines and retrieve their hostnames.

## 7. Windows Virtual Machine

The project also includes one Windows Server 2022 virtual machine.

The Windows VM is created using Terraform's `count` feature.

Its configuration includes:

- Windows Server 2022 Datacenter image.
- Standard D2as v4 VM size.
- One availability set.
- One network interface.
- One public IP address.
- Standard LRS operating system disk.
- Boot diagnostics using the common storage account.
- Microsoft Antimalware extension.

The Windows VM is configured with a DNS label so that it can be accessed using its fully qualified domain name.

## 8. Networking and Security

The network module creates the virtual network, subnet, and network security group.

The network security group contains inbound rules for the following ports:

| Port | Purpose |
|---|---|
| 22 | SSH access for Linux virtual machines |
| 3389 | Remote Desktop access for Windows |
| 5985 | Windows Remote Management |
| 80 | HTTP traffic |

The network security group is associated with the subnet so that the configured rules apply to resources connected to that subnet.

Each virtual machine also has its own network interface and public IP address.

**Security note:** These rules are configured to meet the project requirements. In a production environment, access should be restricted to trusted source IP addresses wherever possible rather than exposing management ports to the entire internet.

## 9. Managed Data Disks

The data disk module creates four additional managed disks.

Each disk has:

- 10 GB of storage.
- Standard LRS storage.
- An empty disk configuration.
- One attachment to a virtual machine.

The disks are attached to:

1. Linux VM 1
2. Linux VM 2
3. Linux VM 3
4. Windows VM

This gives each virtual machine an additional data disk separate from its operating system disk.

## 10. Azure Load Balancer

The load balancer module creates a public-facing Azure Load Balancer.

The three Linux virtual machines are connected to its backend address pool through their network interfaces.

The configuration includes:

- A public IP address.
- A load balancer.
- A backend address pool.
- A health probe.
- A load-balancing rule.
- Backend pool associations for all three Linux VMs.

The health probe checks the configured backend service, while the load-balancing rule defines how incoming traffic is handled.

**Implementation note:** The original project requirement referred to a Basic Load Balancer. Azure retired Basic Load Balancer on September 30, 2025. Therefore, I used the Standard Load Balancer instead to keep the project compatible with the current Azure platform.

## 11. Common Infrastructure Resources

The common module creates three resources that support the rest of the infrastructure.

### Log Analytics Workspace

The Log Analytics workspace provides a central location for collecting and working with monitoring data.

### Recovery Services Vault

The Recovery Services vault provides a resource for managing backup and recovery-related services.

### Storage Account

A separate Standard LRS storage account is created for common infrastructure requirements, including virtual machine boot diagnostics.

This storage account is separate from the storage account used for the Terraform remote state backend.

## 12. PostgreSQL Database

The database module creates an Azure Database for PostgreSQL Flexible Server.

The configuration includes:

- PostgreSQL version 16.
- Burstable B1ms compute tier.
- 32 GB storage.
- Seven days of backup retention.
- Geo-redundant backup disabled.
- Public network access enabled.

The database server is deployed in Canada Central, while the other main project resources are deployed in East US.

**Implementation note:** The database was placed in Canada Central because PostgreSQL provisioning was restricted in the selected East US region during deployment. Using a separate region allowed the database resource to be created successfully.

## 13. Remote Terraform State

Terraform state is stored remotely in an Azure Storage Account instead of relying only on a local state file.

The remote backend uses:

- Resource group: `rg-3601-tfstate`
- Storage account: `st3601tfstateak26`
- Container: `tfstate`
- State file: `terraform.tfstate`

The backend uses Azure CLI authentication and Azure AD authentication.

Keeping the state file in Azure Storage allows Terraform to access the same infrastructure state from the configured working environment.

The backend storage account is separate from the project resource group and common storage account.

## 14. Important Implementation Decisions and Limitations

During deployment, a few Azure platform and operating-system compatibility issues required adjustments.

### Load Balancer

The Basic Load Balancer specified in the original project requirement was replaced with a Standard Load Balancer because the Basic SKU has been retired.

### PostgreSQL Region

The PostgreSQL Flexible Server was deployed in Canada Central instead of East US because provisioning was restricted in the selected East US region.

### Linux Monitoring Agent

The Azure Monitor Linux Agent extension was tested with the selected CentOS 8.2 image, but the installation failed because that operating system was reported as unsupported.

I kept the CentOS 8.2 image and removed the unsupported Azure Monitor Agent extension from the final configuration rather than changing the operating system late in the deployment.

The Network Watcher extension remains configured for the Linux VMs.

These decisions were made to keep the deployed infrastructure consistent with the working configuration.

## 15. Deployment Instructions

### Prerequisites

Before deploying this project, make sure you have:

- An active Microsoft Azure subscription.
- Azure CLI installed.
- Terraform installed.
- Git installed.
- Access to the Azure subscription with the required permissions.
- An SSH-capable environment, such as Ubuntu or WSL.

### Step 1 – Clone the Repository

```bash
git clone https://github.com/aishwaryakadavla/ccgc5502-terraform-project.git
```

Move into the project directory:

```bash
cd ccgc5502-terraform-project
```

### Step 2 – Sign in to Azure

```bash
az login
```

Check the active subscription:

```bash
az account show
```

If necessary, select the correct subscription:

```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

### Step 3 – Set the VM Administrator Password

The administrator password is supplied through a Terraform environment variable instead of being written directly into the configuration.

```bash
read -s -p "Enter your admin password: " TF_VAR_vm_admin_password
echo
export TF_VAR_vm_admin_password
```

Do not commit passwords or secret values to GitHub.

### Step 4 – Initialize Terraform

```bash
terraform init
```

This downloads the required providers and initializes the remote backend.

### Step 5 – Format the Configuration

```bash
terraform fmt -recursive
```

This formats the Terraform files consistently, including the files inside the modules.

### Step 6 – Validate the Configuration

```bash
terraform validate
```

This checks whether the Terraform configuration is syntactically valid and internally consistent.

### Step 7 – Review the Deployment Plan

```bash
terraform plan
```

Review the proposed resource changes before applying them.

### Step 8 – Deploy the Infrastructure

```bash
terraform apply --auto-approve
```

This creates the Azure resources defined in the Terraform configuration without asking for interactive approval.

Only use this command after reviewing the Terraform plan.

### Step 9 – View Terraform Outputs

```bash
terraform output
```

This displays the important information returned by the root module, including VM details, IP addresses, DNS names, and resource names.

### Step 10 – View Terraform State

```bash
terraform state list | nl
```

This lists the resources tracked in the Terraform state.

## 16. Cleaning Up Resources

Azure resources can continue generating charges while they are deployed.

After the project has been evaluated and the infrastructure is no longer required, run:

```bash
terraform destroy
```

Review the destruction plan and confirm the operation.

This removes the resources managed by the project configuration.

**Important:** The remote backend storage account and its resource group are separate from the project infrastructure. Keep them available until you no longer need the Terraform state. Do not delete the backend before you have finished using the project state.

## 17. GitHub Repository

The source code for this project is available here:

**GitHub Repository:**  
https://github.com/aishwaryakadavla/ccgc5502-terraform-project

The repository contains the root Terraform configuration, all eight modules, the provider lock file, and the `.gitignore` file.

The `.gitignore` file prevents local Terraform files, state files, plans, and variable files from being included in normal Git commits.

## 18. Conclusion

This project provided practical experience in using Terraform to automate infrastructure deployment in Microsoft Azure.

By separating the configuration into modules, I was able to organize the infrastructure into smaller components and connect them through a root configuration.

The project also helped me understand how virtual machines, networking, storage, managed disks, load balancing, monitoring resources, backup resources, and databases work together in a cloud environment.

Overall, this project demonstrates how Infrastructure as Code can make cloud infrastructure easier to manage, repeat, and maintain.

---
