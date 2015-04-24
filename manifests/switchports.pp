class eos_config::switchports (
  $purge = false,
  $access = '',
  $trunk = '',
  $portchannels = false
) {

  require eos_config

  # In puppet 3, unspecified parameters will automatically be looked up in hiera,
  # thus the following are not necessary:
  #$access = hiera('access', ''),
  #$trunk = hiera('trunk', ''),

  #
  # --hiera example--
  # portchannels:
  #   Port-Channel1:
  #     interfaces: [ 'Ethernet1', 'Ethernet2' ]
  #     mode: active
  #     minimum_links: 2
  #
  # eos_config::switchports::access: [ 'Ethernet1', 'Ethernet2' ]
  # eos_config::switchports::trunk: [ 'Ethernet2', 'Port-Channel1' ]
  #

  $defaults = {
    ensure => present,
  }

  $access_defaults = {
    ensure => present,
    mode   => access,
    purge  => $purge,
  }

  $trunk_defaults = {
    ensure => present,
    mode   => trunk,
    purge  => $purge,
  }

  # generate a resource for each interface entry
  #create_resources(eos_switchport, $portchannels, $defaults)

  define set_trunk {
    eos_switchport { $name:
      ensure => present,
      mode   => trunk,
    }
  }
  set_trunk { $trunk: }

  define set_access {
    eos_switchport { $name:
      ensure => present,
      mode   => access,
    }
  }
  set_access { $access: }
    
}
