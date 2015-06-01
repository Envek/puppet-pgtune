require 'rake'
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

PuppetLint.configuration.send('disable_80chars')

exclude_paths = %w[ pkg/**/* vendor/**/* spec/**/* ]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

desc 'Run syntax, lint, and spec tests.'
task test: [:spec_prep, :validate, :lint, :spec]
