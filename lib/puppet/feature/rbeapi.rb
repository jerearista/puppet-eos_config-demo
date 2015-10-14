require 'puppet/util/feature'
#require 'puppet/util/libuser'

Puppet.features.add(:rbeapi, :libs => ["rbeapi"])
#Puppet.features.add(:rbeapi) {
#   File.executable?("/usr/sbin/lgroupadd") and
#   File.executable?("/usr/sbin/luseradd")  and
#   Puppet::FileSystem.exist?(Puppet::Util::Libuser.getconf)
#}
