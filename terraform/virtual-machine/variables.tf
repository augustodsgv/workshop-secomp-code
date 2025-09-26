variable "mgc_api_key" {
  description = "Api Key da Magalu Cloud"
}

variable "mgc_region" {
  description = "Região da Magalu Cloud"
  default     = "br-se1"
}

variable "ssh_key" {
  description = "Caminho da chave privada de SSH"
}

variable "machine_image" {
  description = "Sistema operacional da VM"
  default     = "cloud-ubuntu-24.04 LTS"
}

variable "machine_type" {
  description = "Especificações da máquina (CPUs, RAM, Disco)"
  default     = "BV1-1-20" # VM com 1 CPU, 1GB RAM e 20GB de disco
}
