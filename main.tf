resource "azurerm_key_vault_secret" "tfe_license" {
  name         = "tfe-license-${var.friendly_name_prefix}"
  value        = filebase64(var.license_file)
  key_vault_id = var.key_vault_id
}

module "tfe" {
  source = "github.com/tmekaumput/terraform-azurerm-terraform-enterprise?ref=v1.0.1"

  location             = var.location
  friendly_name_prefix = var.friendly_name_prefix

  resource_group_name     = var.resource_group_name
  resource_group_name_dns = var.resource_group_name_dns

  domain_name   = var.domain_name
  tfe_subdomain = var.tfe_subdomain

  user_data_iact_subnet_list  = var.iact_subnet_list

  tfe_license_secret        = azurerm_key_vault_secret.tfe_license
  load_balancer_certificate = data.azurerm_key_vault_certificate.load_balancer
  vm_certificate_secret     = data.azurerm_key_vault_secret.vm_certificate
  vm_key_secret             = data.azurerm_key_vault_secret.vm_key
  ca_certificate_secret     = data.azurerm_key_vault_secret.vm_ca


  tags = var.tags

  create_bastion = true
  
  private_link_enforced = true
  dedicated_subnets = true

  allow_blob_public_access = false
  network_rules_default_action = "Deny"
  default_action_ip_rules = [chomp(data.http.icanhazip.body)]

  database_flexible_server = false
  database_machine_type = "GP_Gen5_2"
  database_version = "11"

  # vm_sku = "Standard_B1s"
  vm_sku = "Standard_D4_v3"
  vm_node_count = 1
}

resource "null_resource" "wait_for_tfe" {

  triggers = {
    "always" = uuid()
  }

  provisioner "local-exec" {
    command = "bash ${path.module}/files/wait_for.sh \"${module.tfe.tfe_console_url}\" 200 1200"
  }

  provisioner "local-exec" {
    command = "bash ${path.module}/files/wait_for.sh \"${module.tfe.tfe_application_url}\" 200 1200"
  }

  depends_on = [
    module.tfe
  ]
}

data "http" "iact" {
  url = "https://${var.tfe_subdomain}.${var.domain_name}/admin/retrieve-iact"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }

  depends_on = [
    null_resource.wait_for_tfe
  ]
}

output "iact" {
  value = data.http.iact.body
}
