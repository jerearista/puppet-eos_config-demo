class eos_config::switchports ($trunk = [], $access = []) {
  if $trunk {
    eos_config::switchport::trunk { $trunk: }
  }

  if $access {
    eos_config::switchport::access { $access: }
  }
}
