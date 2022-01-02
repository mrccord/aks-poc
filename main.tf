resource "azurerm_resource_group" "aks-poc" {
  name = "aks-poc"
  location = var.location
}

module "k8s" {
  source              = "./modules/k8s"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-poc.name
}

module "azurefile" {
  source               = "./modules/azure_files"
  location             = var.location
  resource_group_name  = azurerm_resource_group.aks-poc.name
  storage_account_name = var.storage_account_name
}

module "k8s_config" {
  source                 = "./modules/k8s_config"
  client_certificate     = module.k8s.client_certificate
  client_key             = module.k8s.client_key
  cluster_ca_certificate = module.k8s.cluster_ca_certificate
  host                   = module.k8s.host
  location               = var.location
  storage_account_name   = var.storage_account_name
}

module "helm" {
  source                 = "./modules/helm"
  client_certificate     = module.k8s.client_certificate
  client_key             = module.k8s.client_key
  cluster_ca_certificate = module.k8s.cluster_ca_certificate
  host                   = module.k8s.host
}
