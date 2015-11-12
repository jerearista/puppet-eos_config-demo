class eos_config::switchports ($trunk = [], $access = []) {
  if $trunk {
    eos_config::switchport::trunk { $trunk: }
  }
  require Class['eos_config']

  if $access {
    eos_config::switchport::access { $access: }
  }
}
