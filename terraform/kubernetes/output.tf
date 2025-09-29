# Pega kubeconfig do cluster
data "mgc_kubernetes_cluster_kubeconfig" "workshop_secomp_kubeconfig" {
  cluster_id = mgc_kubernetes_cluster.workshop_secomp.id
}

resource "local_file" "kubeconfig" {
  filename = "../../kubeconfig.yaml"
  content  = data.mgc_kubernetes_cluster_kubeconfig.workshop_secomp_kubeconfig.kubeconfig
}