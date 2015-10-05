source 'https://rubygems.org'

rbeapiversion = ENV.key?('RBEAPI_VERSION') ? "#{ENV['RBEAPI_VERSION']}" : ['>= 0.3.0']
puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.8.2'
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '>= 1.7.0'
gem 'metadata-json-lint'
gem 'rbeapi', rbeapiversion

group :development, :test do
  gem 'pry', :require => false
end
