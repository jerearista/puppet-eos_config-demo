class eos_config::snmp (
  $purge = false,
  $snmp             = hiera('snmp'),
  #$contact          = hiera('contact', undef),
  #$chassis_id       = hiera('location', undef),
  #$location         = hiera('location', undef),
  #$source_interface = hiera('source_interface', undef),
  $communities      = hiera('communities')
) {

  #require eos_config

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
    #ensure => present,
    group  => ro,
  }

  #eos_snmp { 'settings':
  #  chassis_id       => $chassis_id,
  #  contact          => $contact,
  #  location         => $location,
  #  source_interface => $source_interface,
  #}
    #source_interface => $source_interface if $source_interface,

  if $operatingsystem == 'AristaEOS' {
    # generate a resource for each entry in $vlans
    create_resources(eos_snmp, $snmp)
    create_resources(snmp_community, $communities, $defaults)
  }
}
