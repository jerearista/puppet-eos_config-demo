# == Class: eos_config
#
# High level setup for the eos_config classes
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
#  class { eos_config:
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
class eos_config {
  notify { 'eos_config::init': }

  # Need to rewrite management of rbeapi package and eapi.conf
  #require rbeapi

}
