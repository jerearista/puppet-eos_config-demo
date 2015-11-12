# == Class: eos_config::l3interface
#
# Configure Layer-3 interfaces from a hash of interface config hashes
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  Hiera:
#
#    l3interfaces:
#      Management1: { address: '192.168.0.2/24', mtu: '1500' }
#      Ethernet1: { address: '172.16.130.101/24', helper_addresses: ['10.0.2.2'] }
#      Ethernet2: { address: '192.168.100.1/24', ensure: absent }
#  
#  class { eos_config::l3interfaces:
#    interfaces => { Management1: { address: '192.168.0.2/24', mtu: '1500' },
#                    Ethernet2: { address: '192.168.100.1/24', ensure: absent },
#                  },
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

class eos_config::l3interfaces (
  $l3interfaces = hiera('l3interfaces', {}),
  $purge = false,
  ) {
  require Class['eos_config']

  $defaults = {
    ensure => present,
  }

  resources { 'eos_ipinterface':
    purge => $purge,
    noop  => false,
  }

  # generate a resource for each entry in $vlans
  create_resources(eos_ipinterface, $l3interfaces, $defaults)

}
