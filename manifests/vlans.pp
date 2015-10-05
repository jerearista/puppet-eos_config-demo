# Comment stuff
class eos_config::vlans ($purge = false) {
  $vlans = hiera('vlans', {})
  create_resources( eos_vlan, $vlans )

  $test = generate('/bin/grep', 'localhost', '/etc/hosts')

  resources { 'eos_vlan':
    purge => $purge,
  }
}
