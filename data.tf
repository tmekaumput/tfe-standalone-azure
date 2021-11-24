data "azurerm_key_vault_certificate" "load_balancer" {
  name         = var.load_balancer_key_vault_certificate_name
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "vm_certificate" {
  name         = var.vm_certificate_key_vault_secret_name
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "vm_key" {
  name         = var.vm_private_key_key_vault_secret_name
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "vm_ca" {
  name         = var.vm_ca_key_vault_secret_name
  key_vault_id = var.key_vault_id
}

data "http" "icanhazip" {
   url = "http://icanhazip.com"
}