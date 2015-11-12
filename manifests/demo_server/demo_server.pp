class eos_config::demo_server::demo_server (
  $confdir = '/etc/puppetlabs/puppet',
  $owner = 'ztpsadmin',
  $group = 'ztpsadmin',
  $environment = undef,
  $master_enable = true,
) {

  if $::is_pe == true {
    $masterservice = 'pe-puppetserver'
    #$confdir = '/etc/puppetlabs/puppet',
    $libdir = '/var/opt/lib/pe-puppet/lib'
  } else {
    $masterservice = 'puppetmaster'
    #$confdir = '/etc/puppet',
    $libdir = '/var/lib/puppet/lib'
  }

  if $environment {
    $envdir = "${confdir}/environments/${environment}"
  } else {
    $envdir = $confdir
  }

  $manifestdir = "${envdir}/manifests"
  $moduledir = "${confdir}/modules"

  File {
    owner => $owner,
    group => $group,
    mode  => '0664',
  }

  package { 'tree':
    ensure => present,
  }

  $rubydev = $::osfamily ? {
    'Debian' => 'ruby-dev',
    'RedHat' => 'ruby-devel',
    default  => 'ruby-dev',
  }

  package { 'Ruby development environment':
    ensure => present,
    name   => $rubydev,
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

  file { $moduledir:
    ensure => directory,
    mode   => '0755',
  }

  # r10k Puppetfile
  file { "${envdir}/../Puppetfile":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/Puppetfile',
    require => File[$moduledir],
  }

  file { "${confdir}/hiera.yaml":
    ensure  => file,
    #source => 'puppet:///modules/eos_config/hiera.yaml',
    content => template('eos_config/hiera.yaml.erb'),
    notify  => Service['puppetmaster'],
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
    ensure  => directory,
    mode    => '0755',
    require => File["${confdir}/hieradata"],
  }

  file { "${confdir}/hieradata/oses/AristaEOS.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/AristaEOS.yaml',
    require => File["${confdir}/hieradata/oses"],
  }

  file { "${confdir}/hieradata/roles":
    ensure  => directory,
    mode    => '0755',
    require => File["${confdir}/hieradata"],
  }

  file { "${confdir}/hieradata/roles/spine.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/spine.yaml',
    require => File["${confdir}/hieradata/roles"],
  }

  file { "${confdir}/hieradata/roles/leaf.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/leaf.yaml',
    require => File["${confdir}/hieradata/roles"],
  }

  file { "${confdir}/hieradata/nodes":
    ensure  => directory,
    mode    => '0755',
    require => File["${confdir}/hieradata"],
  }

  file { "${confdir}/hieradata/nodes/veos1.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/veos1.yaml',
    require => File["${confdir}/hieradata/nodes"],
  }

  file { "${confdir}/hieradata/nodes/veos2.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/veos2.yaml',
    require => File["${confdir}/hieradata/nodes"],
  }

  file { "${confdir}/hieradata/nodes/veos3.yaml":
    ensure  => file,
    source  => 'puppet:///modules/eos_config/veos3.yaml',
    require => File["${confdir}/hieradata/nodes"],
  }

  exec { 'puppet plugin download':
    path    => '/opt/puppet/bin:/usr/bin',
    creates => "${libdir}/puppet_x/eos",
  }

  service { 'puppetmaster':
    ensure => running,
    name   => $masterservice,
    enable => $master_enable,
  }

}
