#
# Run this to manage Ravello demo installations
#
#  sudo puppet apply /etc/puppetlabs/puppet/envitonments/production/modules/eos_config/manifests/demo_derver/ravello.pp
#
class {'eos_config::demo_server::demo_server':
  confdir       => '/etc/puppetlabs/puppet',
  owner         => 'ubuntu',
  group         => 'ubuntu',
  environment   => 'production',
  master_enable => true,
}

$hieradir = '/etc/puppetlabs/puppet/hieradata'

file { "${hieradir}/nodes/larry.localdomain.yaml":
  ensure => link,
  target => "${hieradir}/nodes/veos1.yaml",
}

file { "${hieradir}/nodes/curly.localdomain.yaml":
  ensure => link,
  target => "${hieradir}/nodes/veos2.yaml",
}

file { "${hieradir}/nodes/moe.localdomain.yaml":
  ensure => link,
  target => "${hieradir}/nodes/veos3.yaml",
}
