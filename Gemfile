source 'https://rubygems.org'

gem 'rake'
puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.0.0','< 5.0']
gem 'puppet', puppetversion
gem 'puppet-lint'
gem 'metadata-json-lint'
gem 'rspec-puppet', '~> 2.0'
gem 'puppetlabs_spec_helper'
gem 'puppet-syntax'
gem 'librarian-puppet'

if RUBY_VERSION =~ /^1\.9\./ or RUBY_VERSION =~ /^1\.8\./
  gem 'json', '< 2.0' # newer versions requires at least ruby 2.0
  gem 'json_pure', '< 2.0.0'
  gem 'fog-google', '< 0.1.1'
end
