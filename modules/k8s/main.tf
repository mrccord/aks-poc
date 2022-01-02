resource "azurerm_kubernetes_cluster" "aks-poc" {
  name                = "aks-poc"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-poc"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Test"
  }
}
