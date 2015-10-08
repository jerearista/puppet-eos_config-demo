class eos_config::rbeapi (
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

  package { 'inifile':
    ensure => [${inifile_ver}],
  }

  package { 'net_http_unix':
    ensure => [${net_http_unix_ver}],
  }

  package { 'netaddr':
    ensure => [${netaddr_ver}],
  }

  package { 'rbeapi':
    ensure => [${rbeapi_ver}],
    #source => "puppet:///modules/eos_config/rbeapi-0.3.0.gem",
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
