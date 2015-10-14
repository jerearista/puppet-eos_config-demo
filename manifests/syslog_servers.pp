class eos_config::syslog_servers ($purge = false) {
  require Class['eos_config']
  $syslog_servers = hiera('syslog_servers', {})
  create_resources( syslog_server, $syslog_servers )

  resources { 'syslog_server':
    purge => $purge,
  }
}
