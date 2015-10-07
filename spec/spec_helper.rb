require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.environmentpath = File.join(Dir.pwd, 'spec')
  # http://rnelson0.com/2014/12/31/puppet-rspec-tests-with-hiera-data/
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
end
