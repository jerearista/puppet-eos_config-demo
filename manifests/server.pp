#class eos_config::master {

  #$confdir = '/etc/puppet'
  $confdir = '/etc/puppetlabs/puppet'
  #$confdir = generate('puppet', 'config', 'print', 'confdir')

  $manifestdir = "${confdir}/environments/production/manifests"
  $moduledir = "${confdir}/environments/production/modules"

  if $is_pe {
    $masterservice = 'pe-puppetserver'
  } else {
    $masterservice = 'puppetmaster'
  }

  File {
    owner => ubuntu,
    group => ubuntu,
    #owner => ztpsadmin,
    #group => ztpsadmin,
    mode  => '0664',
  }

  package { 'tree':
    ensure => present,
  }

  package { 'rbeapi':
    ensure   => present,
    provider => gem,
  }

  package { 'r10k':
    ensure   => present,
    provider => gem,
  }

  file { "${manifestdir}/site.pp":
    ensure => file,
    source => 'puppet:///modules/eos_config/site.pp',
  }

  file { "${moduledir}":
    ensure => directory,
    mode   => '0755',
  }

  # r10k Puppetfile
  file { "${moduledir}/../Puppetfile":
    ensure => file,
    source => 'puppet:///modules/eos_config/Puppetfile',
    require => File["${moduledir}"],
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
    path    => '/opt/puppet/bin:/usr/bin',
    creates => '/var/lib/puppet/lib/puppet_x/eos',
  }

  service { 'puppetmaster':
    name   => $masterservice,
    ensure => running,
    enable => true,
  }

#}
