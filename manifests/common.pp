# == Class: eos_config::common
#
# Defaults for all EOS nodes
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { eos_config::common:
#  }
#
# === Authors
#
# Jere Julian <jere@arista.com>
#
# === Copyright
#
# Copyright 2015 Arista Networks here, unless otherwise noted.
#
class eos_config::common (
  $motd = "\nManaged by puppet\n\n",
) {
  #notify { 'eos_config::common': }

  # Need to rewrite management of rbeapi package and eapi.conf
  #require rbeapi

  file { '/etc/motd':
    content => $motd,
  }

}
