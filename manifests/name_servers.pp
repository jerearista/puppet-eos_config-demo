class eos_config::name_servers (
  $name_servers,
) {

  if $operatingsystem == 'AristaEOS' {
    name_server { $name_servers: }
  }
}
