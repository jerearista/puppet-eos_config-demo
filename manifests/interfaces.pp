class eos_config::interfaces {
  $interfaces = hiera('interfaces', {})
  create_resources( eos_interface, $interfaces )
}
