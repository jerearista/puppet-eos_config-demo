# == Class: eos_config::vlans
#
# Configure vlans interfaces from a hash of vlan configs
#
# === Parameters
#
# Document parameters here.
#
# [*vlans*]
#   Vlans is a hash, keyed on VLAN ID, in which each value is a hash of
#   eos_vlan settings
#
# [*purge*]
#   If set to `true`, all VLANS not managed by Puppet will be removed from the
#   device.  Default: false.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*eos_conig::vlans::purge*]
#   If set to `true`, all VLANS not managed by Puppet will be removed from the
#   device.  Default: false.
#
# === Examples
#
#  Hiera:
#
#    vlans:
#      1: { vlan_name: default }
#      100: { vlan_name: Test_vlan_100 }
#
#  class { eos_config::vlans:
#    vlans => { 1: { vlan_name: default },
#               100: { vlan_name: Test_vlan_100 },
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
class eos_config::vlans (
  $vlans = hiera('vlans', {}),
  $purge = false,
  ) {

  require rbeapi

  $defaults = {
    ensure => present,
  }

  resources { 'eos_vlan':
    purge  => $purge,
    noop   => true,
  }

  # generate a resource for each entry in $vlans
  create_resources(eos_vlan, $vlans, $defaults)

}
