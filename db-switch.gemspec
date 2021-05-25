lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db-switch/version'

Gem::Specification.new do |spec|
  spec.name          = 'db-switch'
  spec.version       = DbSwitch::VERSION
  spec.authors       = ['Anjlab']
  spec.email         = ['sergey.glukhov@gmail.com']

  spec.summary       = 'Simple database connection switcher for Rails 5'
  spec.description   = 'Dead-simple gem for Rails 5 that allows to switch between database connections on-the-fly'
  spec.homepage      = 'https://github.com/anjlab/db-switch'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pg', '~> 0.19'
  spec.add_development_dependency 'rubocop', '0.50.0'
  spec.add_development_dependency 'appraisal', '~> 2.1'

  # Rails 5 dependencies
  spec.add_runtime_dependency 'activerecord', '~> 5.0'
  spec.add_runtime_dependency 'railties', '~> 5.0'
end
