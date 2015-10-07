$loopback = get_loopback('/home/ztpsadmin/Demo_IPAM.xls')
notify { "The loopback address for ${::hostname} is ${loopback}": }
