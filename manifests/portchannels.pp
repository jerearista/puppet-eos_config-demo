# == Class: eos_config::portchannels
#
# Configure portchannel interfaces from a hash of interface configs
#
# === Parameters
#
# Document parameters here.
#
# [*portchannels*]
#   portchannels is a hash, keyed on interface-name, in which each value is a
#   hash of eos_portchannel settings
#
# [*purge*]
#   If set to `true`, all port-channels not managed by Puppet will be removed
#   from the device.  Default: false.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*eos_conig::portchannels::purge*]
#   If set to `true`, all port-channels not managed by Puppet will be removed
#   from the device.  Default: false.
#
# === Examples
#
#  Hiera:
#
#    portchannels:
#      Port-Channel1:
#        interfaces: ['Ethernet3', 'Ethernet4']
#        mode: active
#        minimum_links: 2
#
#  class { eos_config::portchannels:
#    vlans => { Port-Channel1=>{
#                                interfaces    => ['Ethernet3', 'Ethernet4'],
#                                mode          => active,
#                                minimum_links => 2,
#                              },
#             },
#    purge => false,
#  }
#
# === Authors
#
# Arista EOS+ CS <eosplus-dev@arista.com>
#
# === Copyright
#
# Copyright 2015 Arista Networks, unless otherwise noted.
#
class eos_config::portchannels (
  $vlans = hiera('portchannels', {}),
  $purge = false,
  ) {

  require eos_config

  $defaults = {
    ensure => present,
    enable => true,
  }

  resources { 'eos_portchannel':
    purge  => $purge,
    noop   => true,
  }

  # generate a resource for each entry in $vlans
  create_resources(eos_portchannel, $vlans, $defaults)

}
