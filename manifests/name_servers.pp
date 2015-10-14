class eos_config::name_servers (
  $name_servers,
) {
  require Class['eos_config']

  if $::operatingsystem == 'AristaEOS' {
    name_server { $name_servers: }
  }
}
