class eos_config::mlag_downlinks ($purge = false) {
  $mlag_downlinks = hiera('mlag_downlinks', {})
  create_resources( eos_config::mlag_portchannel, $mlag_downlinks )

  #resources { "eos_config::mlag_portchannel":
  #  purge => $purge,
  #}
}
