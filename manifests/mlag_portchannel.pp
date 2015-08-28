class eos_config::mlag_portchannel (
  $mlag,
  $port_channel,
  $members,
) {

  eos_config::portchannel::member { $members: }

  eos_interface { $port_channel:
    description => 'managed by puppet',
  }

  eos_switchport { $port_channel:
    mode => trunk,
    trunk_native_vlan   => 100,
    trunk_allowed_vlans => ['101', '102', '103', '104'],
  }

  eos_portchannel { $port_channel:
    ensure    => present,
    lacp_mode => active,
    members   => $members,
    require   => Eos_interface[$port_channel],
  }

  eos_mlag_interface { $port_channel:
    mlag_id => $mlag,
    require => Eos_portchannel[$port_channel],
  }
}
