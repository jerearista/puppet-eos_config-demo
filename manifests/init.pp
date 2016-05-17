class eos_config (
  $inifile_ver = '3.0.0',
  $net_http_unix_ver = '0.2.1',
  $netaddr_ver = '1.5.0',
  $rbeapi_ver = '0.3.0',
  $inifile_path = undef,
  $net_http_unix_path = undef,
  $netaddr_path = undef,
  $rbeapi_path = undef,
) {

  Package {
    provider => puppetagent_gem,
  }

  if $inifile_path {
    $inifile = "/persist/sys/inifile-${inifile_ver}.gem"
    file { 'inifile':
      path   => $inifile,
      source => $inifile_path,
      before => Package['inifile'],
    }
  #} else {
  #  $inifile = undef
  }

  if $net_http_unix_path {
    $net_http_unix = "/persist/sys/net_http_unix-${net_http_unix_ver}.gem"
    file { 'net_http_unix':
      path => $net_http_unix,
      source => $net_http_unix_path,
      before => Package['net_http_unix'],
    }
  #} else {
  #  $net_http_unix = undef
  }

  if $netaddr_path {
    $netaddr = "/persist/sys/netaddr-${netaddr_ver}.gem"
    file { 'netaddr':
      path => $netaddr,
      source => $netaddr_path,
      before => Package['netaddr'],
    }
  #} else {
  #  $netaddr = undef
  }

  if $rbeapi_path {
    $rbeapi = "/persist/sys/rbeapi-${rbeapi_ver}.gem"
    file { 'rbeapi':
      path => $rbeapi,
      source => $rbeapi_path,
      before => Package['rbeapi'],
    }
  #} else {
  #  $rbeapi = undef
  }

  package { 'inifile':
    ensure => [$inifile_ver],
    source => $inifile,
  }

  package { 'net_http_unix':
    ensure => [$net_http_unix_ver],
    source => $net_http_unix,
  }

  package { 'netaddr':
    ensure => [$netaddr_ver],
    source => $netaddr,
  }

  package { 'rbeapi':
    ensure => [$rbeapi_ver],
    source => $rbeapi,
  }

  # Uncomment for "online" gem fetching
  #
  #package { 'rbeapi':
  #  ensure => latest,
  #  provider => 'gem',
  #}

  # Update gem with:
  #   cd modules/eos_config/files; gem fetch rbeapi
  #   ... then update the filenames, below
  #
  #$rbeapi_file = "rbeapi-0.1.0.gem"
  #file {"rbeapi-gem":
  #  name => "/mnt/flash/$rbeapi_file",
  #  ensure => file,
  #  owner => root,
  #  group => eosadmin,
  #  source => "puppet:///modules/eos_config/$rbeapi_file",
  #}
  #package { 'rbeapi':
  #  ensure => installed,
  #  provider => gem,
  #  source => "/mnt/flash/$rbeapi_file",
  #  require => File[rbeapi-gem],
  #}

}
