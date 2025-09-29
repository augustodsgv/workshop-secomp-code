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
#                      Virtual Machine                        #
###############################################################

# Criação da ssh key.
# A chave SSH é usada para se autenticar na máquina virtual.
resource "mgc_ssh_keys" "workshop_secomp" {
  name = "workshop_secomp"
  key  = file(var.ssh_key)
}

# Criação da máquina virtual (VM)
# A VM é um servidor que pode ser usado para rodar aplicações,
# como nosso o site estático.
resource "mgc_virtual_machine_instances" "workshop_secomp" {
  name         = "workshop_secomp"
  machine_type = var.machine_type
  image        = var.machine_image
  ssh_key_name = mgc_ssh_keys.workshop_secomp.name
}


###############################################################
#                           Network                           #
###############################################################

# Criação da VPC (Virtual Private Cloud).
# Uma VPC é uma rede privada que isola projetos e
# agrupa componentes de rede.
resource "mgc_network_vpcs" "workshop_secomp" {
  name        = "workshop_secomp"
  description = "VPC para o site estatico do workshop da MGC"
}

# Criação do IP público
# O IP público é usado para expor nossa aplicação à internet.
resource "mgc_network_public_ips" "workshop_secomp" {
  description = "IP publico para o site estatico da MGC"
  vpc_id      = mgc_network_vpcs.workshop_secomp.id
}

# Criação do Public IP Attach
# O "Attach" é usado para associar o IP à VM.
resource "mgc_network_public_ips_attach" "workshop_secomp" {
  public_ip_id = mgc_network_public_ips.workshop_secomp.id
  interface_id = mgc_virtual_machine_instances.workshop_secomp.network_interfaces[0].id
}

# Criação do Security Group (SG)
# O SG é usado como um firewall, definindo quais acessos podem
# ser feitos (ou não) para a VM.
resource "mgc_network_security_groups" "workshop_secomp" {
  name        = "workshop_secomp"
  description = "Security Group para controlar acesso ao servidor"
}

# Criação das Security Group Rules
# As rules definem as regras de tráfego que o SG permite,
# como quais IPs de origem e portas são permitidas.
resource "mgc_network_security_groups_rules" "allow_ssh" {
  description       = "Liberar tráfego SSH"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = 22
  port_range_min    = 22
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.workshop_secomp.id
}

resource "mgc_network_security_groups_rules" "allow_http" {
  description       = "Liberar tráfego HTTP"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = 80
  port_range_min    = 80
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.workshop_secomp.id
}

# Criação da Security Group Attach
# O "Attach" é usado para associar o SG à VM.
resource "mgc_network_security_groups_attach" "workshop_secomp" {
  security_group_id = mgc_network_security_groups.workshop_secomp.id
  interface_id      = mgc_virtual_machine_instances.workshop_secomp.network_interfaces[0].id
}