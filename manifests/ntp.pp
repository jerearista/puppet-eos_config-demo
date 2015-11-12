class eos_config::ntp (
  $purge            = false,
  $source_interface = hiera('ntp::source_interface', undef),
  $servers          = hiera('ntp::servers')
) {
  require Class['eos_config']

  $defaults = {
    ensure => present,
  }

  if $::operatingsystem == 'AristaEOS' {
    # generate a resource for each entry in $vlans
    eos_ntp_config { 'settings':
      source_interface => $source_interface,
    }
    eos_ntp_server { $servers: }
  }
}
