define eos_config::portchannel::member {
  eos_interface { $name:
    description => 'managed by puppet eos_config::portchannel::member',
    enable      => true,
  }
}
