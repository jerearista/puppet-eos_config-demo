# See https://docs.puppetlabs.com/learning/templates.html
# See https://docs.puppetlabs.com/learning/modules2.html
class eos_config::eapi_conf (
  $host = 'localhost',
  $transport = https,
  $username = admin,
  $password = ''
) {

  # Uncomment for "online" gem fetching
  #
  #package { 'rbeapi':
  #  ensure => latest,
  #  provider => 'gem',
  #}

  # Update gem with:
  #   cd modules/eos_config/files; gem fetch rbeapi
  #   ... then update the filenames, below
  #
  $rbeapi_file = 'rbeapi-0.1.0.gem'
  file {'rbeapi-gem':
    ensure => file,
    name   => "/mnt/flash/${rbeapi_file}",
    owner  => root,
    group  => eosadmin,
    source => "puppet:///modules/eos_config/${rbeapi_file}",
  }
  package { 'rbeapi':
    ensure   => installed,
    provider => gem,
    source   => '/mnt/flash/$rbeapi_file',
    require  => File[rbeapi-gem],
  }

  # Facts:
  # eos_software_image_version
  # operatingsystemrelease

  $section = split($::operatingsystemrelease, '\.')
  $major = $section[0]
  $minor = $section[1]
  if $section[2] =~ /^(\d+)/ {
    $patch = $1
  } else {
    $patch = 0
  }

  # This file is no longer required at EOS 4.14.5, if using unix-sockets
  if $major >= 4 and $minor >= 14 and $patch >= 5 {
    if $transport {
      if $transport == 'socket' or $transport == 'unix-socket' {
        # We really don't need anything further.  We can drop an empty file
        #  or nothing at all.
        $no_file = true
      } else {
        # If you want to use http_local, then username/password are still
        # required just like other transports.
        $_transport = $transport
        $_username = $username
        $_password = $password
      }
    } else {
      # Assume unix-socket if EOS ver is high enough
      #$_transport = socket
      $no_file = true
    }
  } else {
    # Just pass through values we received
    $_transport = $transport
    $_username = $username
    $_password = $password
  }

  #notify { "$::operatingsystemrelease -> $major, $minor, $patch - http_local: $http_local": }

  $ensure_me = $no_file?{
                false => file,
                true  => absent,
              },

  file { 'eapi.conf':
    ensure  => $ensure_me,
    path    => '/mnt/flash/eapi.conf',
    content => template('eos_config/eapi.conf.erb'),
    #require => Package['rbeapi'],
  }
}
