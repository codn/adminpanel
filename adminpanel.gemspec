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
    supports facebook sharing, twitter, instagram and google analytics integration}
  spec.summary       = %q{Made with <3 by CoDN}
  spec.homepage      = 'https://github.com/codn/adminpanel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib', 'app/assets']

  spec.required_ruby_version = '>= 2.0.0'

  spec.requirements  << 'imagemagick installed'

  spec.add_runtime_dependency 'rails',       '>= 4.2.0', '< 5.0.0'
  spec.add_runtime_dependency 'mini_magick', '4.1.0'
  spec.add_runtime_dependency 'bcrypt',      '~> 3.1',   '>= 3.1.7'
  spec.add_runtime_dependency 'carrierwave', '~> 0.10',  '>= 0.10.0'
  spec.add_runtime_dependency 'cancancan',   '~> 1.10.1', '>= 1.10.1'

  # Implemented APIs
  spec.add_runtime_dependency 'google-api-client', '0.8.2'  # Google analytics
  spec.add_runtime_dependency 'instagram',         '1.1.3'  # Instagram
  spec.add_runtime_dependency 'koala',             '1.10.1' # Facebook
  spec.add_runtime_dependency 'omniauth-twitter',  '1.1.0'  # login Twitter
  spec.add_runtime_dependency 'twitter',           '5.14.0' # Twitter

  # Asset dependencies
  spec.add_runtime_dependency 'coffee-rails',       '~> 4.1.0', '>= 4.1.0'
  spec.add_runtime_dependency 'font-awesome-rails', '~> 4.2',   '>= 4.2.0'
  spec.add_runtime_dependency 'jquery-rails',       '4.0.3'
  spec.add_runtime_dependency 'jquery-ui-rails',    '5.0.3'
  spec.add_runtime_dependency 'sass-rails',         '~> 5.0.0', '>= 5.0.0'
  spec.add_runtime_dependency 'turbolinks',         '~> 2.5.0', '>= 2.5.2'

  # Development dependencies
  spec.add_runtime_dependency 'faker', '~> 1.3',   '>= 1.3.0'

  # Test dependencies
  spec.add_development_dependency 'minitest',         '>= 5.4.0', '<= 6.0.0'
  spec.add_development_dependency 'minitest-emoji',   '2.0.0'
  spec.add_development_dependency 'minitest-capybara','~> 0.7',   '>= 0.7.1'
  spec.add_development_dependency 'poltergeist',      '~> 1.5',   '>= 1.5.1'
  spec.add_development_dependency 'sqlite3',          '~> 1.3',   '1.3.10'
end
