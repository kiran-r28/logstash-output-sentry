Gem::Specification.new do |s|
  s.name          = 'logstash-output-sentry'
  s.version       = '0.1.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Sentry output plugin'
  s.description   = 'Logstash output plugin for sentry'
  s.homepage      = ''
  s.authors       = ['kiran-r28']
  s.email         = 'kiran.radhakrishnan@dcis.net'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "logstash-codec-plain"
  s.add_development_dependency "logstash-devutils"
  s.add_runtime_dependency "sentry-raven", "~> 2.3"
end
