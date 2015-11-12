class eos_config::interfaces {
  require Class['eos_config']
  $interfaces = hiera('interfaces', {})
  create_resources( eos_interface, $interfaces )
}
