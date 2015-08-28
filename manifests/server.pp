#class eos_config::master {

  $confdir = '/etc/puppet'

  package { 'tree':
    ensure => present,
  }

  package { 'rbeapi':
    ensure   => present,
    provider => gem,
  }

  File {
    owner => ztpsadmin,
    group => ztpsadmin,
    mode  => '0644',
  }

  file { "${confdir}/manifests/site.pp":
    ensure => file,
    source => 'puppet:///modules/eos_config/site.pp',
  }

  file { "${confdir}/modules":
    ensure => directory,
    mode   => '0755',
  }

  file { "${confdir}/hiera.yaml":
    ensure => file,
    source => 'puppet:///modules/eos_config/hiera.yaml',
    notify => Service['puppetmaster'],
  }

  file { "${confdir}/hieradata":
    ensure => directory,
    mode   => '0755',
  }

  file { "${confdir}/hieradata/common.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/common.yaml',
    require => File["${confdir}/hieradata"],
  }

  file { "${confdir}/hieradata/oses":
    ensure => directory,
    mode   => '0755',
    require => File["${confdir}/hieradata"],
  }

  file { "${confdir}/hieradata/oses/AristaEOS.yaml":
    ensure => file,
    source => 'puppet:///modules/eos_config/AristaEOS.yaml',
    require => File["${confdir}/hieradata/oses"],
  }

  file { "${confdir}/hieradata/nodes":
    ensure => directory,
    mode   => '0755',
    require => File["${confdir}/hieradata"],
  }

  file { "${confdir}/hieradata/nodes/veos1.yaml":
    ensure => file,
    source => 'puppet:///modules/eos_config/veos1.yaml',
    require => File["${confdir}/hieradata/nodes"],
  }

  file { "${confdir}/hieradata/nodes/veos2.yaml":
    ensure => file,
    source => 'puppet:///modules/eos_config/veos2.yaml',
    require => File["${confdir}/hieradata/nodes"],
  }

  file { "${confdir}/hieradata/nodes/veos3.yaml":
    ensure => file,
    source => 'puppet:///modules/eos_config/veos3.yaml',
    require => File["${confdir}/hieradata/nodes"],
  }

  exec { 'puppet plugin download':
    path    => '/usr/bin',
    creates => '/var/lib/puppet/lib/puppet_x/eos',
  }

  service { 'puppetmaster':
    ensure => running,
    enable => false,
  }

#}
