# $confdir/manifests/site.pp
# The Main Manifest
#
# The filebucket option allows for file backups to the server
filebucket { main: server => 'puppet.ztps-test.com' }

# Set global defaults - including backing up all files to the main filebucket and adds a global path
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

#hiera_include('classes')

node /veos\d+/ {
  hiera_include('classes')
}

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  notify { 'env: demo - site.pp  ***default***': }

  #
  # Use hiera for classification
  #
  #hiera_include('classes')
  #include dc01::role::tor_west
}
