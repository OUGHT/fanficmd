lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fanficmd/version'

Gem::Specification.new do |spec|
  spec.name          = 'fanficmd'
  spec.version       = Fanficmd::VERSION
  spec.authors       = ['StragaSevera']
  spec.email         = ['ought@yandex.ru']

  spec.summary       = 'Markdown support for popular fanfiction sites'
  spec.description   = 'Markdown support for popular fanfiction sites:'\
                       'fanfics.me, ficbook.net, samlib.ru and others.'
  spec.homepage      = 'https://github.com/OUGHT/fanficmd'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required'
  end

  spec.files         = `git ls-files -z`.split("\x0")
                         .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'parslet', '~> 1.6'
end
