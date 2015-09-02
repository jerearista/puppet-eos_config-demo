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
