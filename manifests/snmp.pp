class eos_config::snmp (
  $purge = false,
  $snmp             = hiera('snmp'),
  #$contact          = hiera('contact', ''),
  #$location         = hiera('location', ''),
  #$source_interface = hiera('source_interface', ''),
  #$chassis_id       = hiera('chassis_id', ''),
  $communities      = hiera('communities')
) {
  #
  # --hiera example--
  # snmp::contact: 'Fezig'
  # snmp::location: 'The cliffs of despair'
  # 
  # communities:
  #   public: {group: ro}
  #   private: {group: rw}
  #

  $defaults = {
    ensure => present,
    group  => ro,
  }

  require rbeapi

  #eos_snmp { 'settings':
  #  contact          => $contact,
  #  location         => $location,
  #  chassis_id       => $chassis_id,
  #}
    #source_interface => $source_interface if $source_interface,

  # generate a resource for each entry in $vlans
  create_resources(eos_snmp, $snmp)
  create_resources(snmp_community, $communities, $defaults)
}
