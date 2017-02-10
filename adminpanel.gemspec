# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adminpanel/version'

Gem::Specification.new do |spec|
  spec.name          = 'adminpanel'
  spec.version       = Adminpanel::VERSION
  spec.authors       = ['Jose Ramon Camacho', 'Victor Camacho', 'Eduardo Albertos']
  spec.email         = ['info@codn.mx']
  spec.description   = %q{Gem that focus on making a public site's resources very quickly while being very configurable!,
    supports facebook sharing, instagram and google analytics integration}
  spec.summary       = %q{Made with <3 by CoDN}
  spec.homepage      = 'https://github.com/codn/adminpanel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib', 'app/assets']

  spec.required_ruby_version = '>= 2.2.3'

  spec.requirements  << 'imagemagick installed'

  spec.add_runtime_dependency 'rails',       '>= 5.0', '< 5.1'
  spec.add_runtime_dependency 'mini_magick', '4.3.6'
  spec.add_runtime_dependency 'bcrypt',      '~> 3.1',   '>= 3.1.7'
  spec.add_runtime_dependency 'carrierwave', '~> 0.10',  '>= 0.10.0'
  spec.add_runtime_dependency 'cancancan',   '~> 1.13.0','>= 1.13.0'
  spec.add_runtime_dependency 'friendly_id', '~> 5.1.0',   '>= 5.1.0'

  # Implemented APIs
  spec.add_runtime_dependency 'google-api-client', '~> 0.8.6'  # Google analytics
  spec.add_runtime_dependency 'instagram',         '~> 1.1', '>= 1.1.3'
  spec.add_runtime_dependency 'koala',             '2.2.0' # Facebook

  # Asset dependencies
  spec.add_runtime_dependency 'coffee-rails',       '~> 4.2', '>= 4.2.0'
  spec.add_runtime_dependency 'font-awesome-rails', '~> 4.2',   '>= 4.2.0'
  spec.add_runtime_dependency 'jquery-rails',       '~> 4.2', '>= 4.2.0'
  spec.add_runtime_dependency 'jquery-ui-rails',    '~> 5.0.5', '>= 5.0.5'
  spec.add_runtime_dependency 'sass-rails',         '~> 5.0.0', '>= 5.0.0'
  spec.add_runtime_dependency 'turbolinks',         '~> 5', '>= 5'

  # Development dependencies
  spec.add_runtime_dependency 'faker', '~> 1.3',   '>= 1.3.0'

  # Test dependencies
  spec.add_development_dependency 'minitest',         '>= 5.7.0', '<= 6.0.0'
  spec.add_development_dependency 'minitest-emoji',   '2.0.0'
  spec.add_development_dependency 'capybara',         '> 2.10.0'
  spec.add_development_dependency 'minitest-capybara','0.7.1'
  spec.add_development_dependency 'poltergeist'
  spec.add_development_dependency 'sqlite3',          '~> 1.3',   '>= 1.3.12'
  spec.add_development_dependency 'byebug'
end
