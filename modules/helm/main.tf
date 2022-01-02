provider "helm" {
  kubernetes {
    host                   = var.host
    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress"

  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx-ingress-controller"
  create_namespace = true
  namespace        = "nginx-ingress"
}

resource "helm_release" "prom_grafana" {
  name = "prometheus-community"

  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  create_namespace = true
  namespace        = "monitoring"

  values = ["${file("${path.module}/prom-values/values.yaml")}"]
}

resource "helm_release" "aks-app" {
  name             = "aks-app"
  chart            = "${path.module}/app-helm"
  create_namespace = true
  namespace        = "aks-app"
}

resource "helm_release" "elasticsearch" {
  name             = "elastic"
  repository       = "https://helm.elastic.co"
  chart            = "elasticsearch"
  create_namespace = true
  namespace        = "logging"

  values = ["${file("${path.module}/elasticsearch/values.yaml")}"]
}

resource "helm_release" "kibana" {
  name             = "kibana"
  repository       = "https://helm.elastic.co"
  chart            = "kibana"
  create_namespace = true
  namespace        = "logging"
  values           = ["${file("${path.module}/kibana/values.yaml")}"]
}

resource "helm_release" "metricbeat" {
  name             = "metricbeat"
  repository       = "https://helm.elastic.co"
  chart            = "metricbeat"
  create_namespace = true
  namespace        = "logging"
}

resource "helm_release" "logstash" {
  name             = "logstash"
  repository       = "https://helm.elastic.co"
  chart            = "logstash"
  create_namespace = true
  namespace        = "logging"
}
