variable "key_vault_id" {
  type        = string
  description = "The identity of the Key Vault which contains secrets and certificates."
}

variable "license_file" {
  type        = string
  description = "The local path to the Terraform Enterprise license to be provided by CI."
}

# General
# -------
variable "friendly_name_prefix" {
  type        = string
  description = "(Required) Name prefix used for resources"
}

variable "domain_name" {
  type        = string
  description = "Domain to create Terraform Enterprise subdomain within"
}

variable "tfe_subdomain" {
  type        = string
  description = "Subdomain for TFE"
}

# Provider
# --------
variable "location" {
  default     = "East US"
  type        = string
  description = "Azure location name e.g. East US"
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
}

variable "resource_group_name_dns" {
  type        = string
  description = "Name of resource group which contains desired DNS zone"
}

# Certificate
# --------
variable "load_balancer_key_vault_certificate_name" {
  type        = string
  description = "The secret name of the certificate in Key Vault to upload into the load balancer"

} 

variable "vm_certificate_key_vault_secret_name" {
  type        = string
  description = "The secret name of the certificate in Key Vault to upload into TFE installation"
}

variable "vm_private_key_key_vault_secret_name" {
  type        = string
  description = "The secret name of the certificate private key in Key Vault to upload into TFE installation"
}

variable "vm_ca_key_vault_secret_name" {
  type        = string
  description = "The secret name of the certificate private key in Key Vault to upload into TFE installation"
}

# Application config
# ----------
variable "iact_subnet_list" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
  description = "An array of string contains the list of subnets that allows"
} 

# Tags
# ----------
variable "tags" {
  type = map(string)
  default = {}
  description = "A map of string contains tag attributes"
}


# Network Resources
# ----------
variable "dedicated_subnets" {
  type = bool
  default = false
  description = "(Optional) Share subnet with application or having dedicated subnets for the storage and database"
}

variable "create_bastion" {
  default     = true
  type        = bool
  description = "If true, will create Azure Bastion PaaS and required resources https://azure.microsoft.com/en-us/services/azure-bastion/"
}
  
variable "private_link_enforced" {
  default     = false
  type        = bool
  description = "(Optional) Enforce private link policies"
}

variable "allow_blob_public_access" {
  default = false
  type = bool
  description = "'Allow public access to the Storage account"
}

variable "network_rules_default_action" {
  type = string
  description = "Storage account default access rule, which can be 'Allow' or 'Deny'"

  validation {
    condition = contains(["Allow","Deny"], var.network_rules_default_action)  
    error_message = "Storage account default access rule, which can be 'Allow' or 'Deny'."
  }
}

variable "default_action_ip_rules" {
  default = []
  type = list(string)
  description = "The IP rules for the Storage account default action"
}

variable "default_action_subnet_ids" {
  default = []
  type = list(string)
  description = "The Subnet Ids for the Storage account default action"
}

variable "database_flexible_server" {
  type = bool
  default = true
  description = "Type of Postgres database resource, `azurerm_postgresql_flexible_server` or `azurerm_postgresql_server`"
}

variable "database_machine_type" {
  default     = "GP_Standard_D4s_v3"
  type        = string
  description = "Postgres sku short name: tier + family + cores"
}

variable "database_version" {
  default     = 12
  type        = number
  description = "Postgres version"
}

variable "vm_sku" {
  default     = "Standard_D4_v3"
  type        = string
  description = "Azure virtual machine sku"
}


variable "vm_node_count" {
  default     = 2
  type        = number
  description = "The number of instances to create for TFE environment"

  validation {
    condition     = var.vm_node_count <= 5
    error_message = "The vm_node_count value must be less than or equal to 5."
  }
}
