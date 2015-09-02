#
# Run this to manage demo installations on a packer-ztpserver
#
#  sudo puppet apply /etc/puppet/modules/eos_config/manifests/demo_derver/ztps.pp
#
class {'eos_config::demo_server':
  confdir       => '/etc/puppet',
  owner         => 'ztpsadmin',
  group         => 'ztpsadmin',
  master_enable => false,
}
