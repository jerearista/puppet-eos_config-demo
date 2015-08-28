class eos_config::loopback ($address = '') {

  if $address != '' {
    eos_interface { "Loopback0":
      description => 'managed by PE',
    }

    eos_ipinterface { "Loopback0":
      address => $address,
      require => Eos_interface['Loopback0'],
    }
  }
}
