output public_ip {
    value = mgc_virtual_machine_instances.workshop_secomp.network_interfaces[0].ipv4
}