# Comment stuff
class eos_config::vlans ($purge = false) {
  require Class['eos_config']
  $vlans = hiera('vlans', {})
  create_resources( eos_vlan, $vlans )

  resources { 'eos_vlan':
    purge => $purge,
  }
}
