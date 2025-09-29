variable "mgc_api_key" {
  description = "Api Key da Magalu Cloud"
}

variable "mgc_region" {
  description = "Região da Magalu Cloud"
  default     = "br-ne1"
}

variable "kubernetes_version" {
  description = "Versão do kubernetes do cluster"
  default     = "v1.32.3"
}

variable "nodepool_flavor" {
  description = "Especificações dos nós do cluster kubernetes (CPUs, RAM, Disco)"
  default     = "cloud-k8s.i1-c2-r8-d10" # Nós com 2 CPUs, 8GB RAM e 10GB de disco
}

variable "nodepool_replicas" {
  description = "Número de nós do cluster"
  default     = "1"
}