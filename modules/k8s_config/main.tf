provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

resource "kubernetes_storage_class" "azure-storage" {

  metadata {
    name = "standard"
  }

  storage_provisioner = "kubernetes.io/azure-file"
  reclaim_policy      = "Retain"
  parameters = {
    skuName        = "Standard_LRS"
    location       = var.location
    storageAccount = var.storage_account_name
  }

}
