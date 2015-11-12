define eos_config::mlag_portchannel (
  $members,
  $mlag = undef,
  $port_channel = undef,
  $trunk_native_vlan = undef,
  $trunk_allowed_vlans = undef,
) {

  if $mlag {
    $mlagid = $mlag
  } else {
    $mlagid = $name
  }

  if $port_channel {
    $port_channelid = $port_channel
  } else {
    $port_channelid = "Port-Channel${mlagid}"
  }

  eos_config::portchannel::member { $members: }

  eos_interface { $port_channelid:
    description => 'managed by puppet',
  }

  eos_switchport { $port_channelid:
    mode                => trunk,
    trunk_native_vlan   => $trunk_native_vlan,
    trunk_allowed_vlans => $trunk_allowed_vlans,
  }

  eos_portchannel { $port_channelid:
    ensure    => present,
    lacp_mode => active,
    members   => $members,
    require   => Eos_interface[$port_channelid],
  }

  eos_mlag_interface { $port_channelid:
    mlag_id => $mlagid,
    require => Eos_portchannel[$port_channelid],
  }
}
