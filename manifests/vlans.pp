class eos_config::vlans ($purge = false) {
  $vlans = hiera('vlans', {})
  create_resources( eos_vlan, $vlans )

  resources { 'eos_vlan':
    purge => $purge,
  }
}
