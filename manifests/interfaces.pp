# == Class: eos_config::interface
#
# Configure basic interfaces from a hash of interface config hashes
#
# === Parameters
#
# Document parameters here.
#
# [*interfaces*]
#   A hash, keyed on interface name, containing hashes of eos_interface parameters.
#   e.g. interfaces => { Management1: { description: "Managed by puppet",
#                                       enable: true },
#                      },
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*purge*]
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
#    interfaces:
#      Management1: { description: "Managed by puppet", enable: true }
#      Ethernet2: { description: 'Shutdown by Puppet', enable: false }
#  
#  class { eos_config::interfaces:
#    interfaces => { description: "Managed by puppet", enable: true },
#                    description: 'Shutdown by Puppet', enable: false }
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

class eos_config::interfaces (
  $interfaces = hiera('interfaces', {}),
  $purge = false,
  ) {

  require rbeapi

  $defaults = {
    ensure => present,
    enable => true,
  }

  resources { 'eos_interface':
    purge  => $purge,
    noop   => false,
  }

  # generate a resource for each entry in $vlans
  create_resources(eos_interface, $interfaces, $defaults)

}
