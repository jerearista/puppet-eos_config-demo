$loopback = get_loopback()
notify { "The loopback address for ${::hostname} is ${loopback}": }
