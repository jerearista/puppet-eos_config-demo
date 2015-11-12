class eos_config::portchannel (
  $port_channel,
  $members = [],
) {

  eos_portchannel { $port_channel:
    ensure    => present,
    lacp_mode => active,
    members   => $members,
  }

  eos_interface {$port_channel:
    description => 'autogenerated by puppet eos_config::portchannel',
  }

  eos_config::portchannel::member { $members: }

  eos_switchport { $port_channel:
    ensure              => present,
    mode                => trunk,
    trunk_native_vlan   => 100,
    trunk_allowed_vlans => ['101', '102', '103', '104'],
  }
}
