# Comment stuff
class eos_config::vlans ($purge = false) {
  require Class['eos_config']
  $vlans = hiera('vlans', {})
  create_resources( eos_vlan, $vlans )

  $test = generate('/bin/grep', 'localhost', '/etc/hosts')

  resources { 'eos_vlan':
    purge => $purge,
  }
}
