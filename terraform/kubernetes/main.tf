terraform {
  required_providers {
    mgc = {
      source  = "MagaluCloud/mgc"
      version = "0.37.0"
    }
  }
}

provider "mgc" {
  region  = var.mgc_region
  api_key = var.mgc_api_key
}


###############################################################
#                        Kubernetes                           #
###############################################################
resource "mgc_kubernetes_cluster" "workshop_secomp" {
  name        = "workshop-secomp"
  description = "Cluster kubernetes para o workshop da Magalu Cloud na Secomp 2025"
  version     = var.kubernetes_version
}

resource "mgc_kubernetes_nodepool" "workshop_secomp" {
  name        = "workshop-secomp"
  depends_on  = [mgc_kubernetes_cluster.workshop_secomp]
  cluster_id  = mgc_kubernetes_cluster.workshop_secomp.id
  flavor_name = var.nodepool_flavor
  replicas    = var.nodepool_replicas
}

resource "mgc_container_registries" "workshop_secomp" {
    name = "workshop_secomp"
}