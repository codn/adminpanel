# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adminpanel/version'

Gem::Specification.new do |spec|
  spec.name          = 'adminpanel'
  spec.version       = Adminpanel::VERSION
  spec.authors       = ['Jose Ramon Camacho', 'Victor Camacho']
  spec.email         = ['info@codn.mx']
  spec.description   = %q{Gem that makes the CMS for a site a breeze!, supports facebook sharing, twitter, instagram and analytics integration}
  spec.summary       = %q{Made with <3 by CoDN}
  spec.homepage      = 'https://github.com/joseramonc/adminpanel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib', 'app/assets']

  spec.required_ruby_version = '>= 2.0.0'

  spec.requirements  << 'rmagick, -v 2.13.2'

  spec.add_runtime_dependency 'rails', '>= 4.0.0', '<= 4.1.4'
  spec.add_runtime_dependency 'carrierwave', '~> 0.10.0'
  spec.add_runtime_dependency 'rmagick', '2.13.2'
  spec.add_runtime_dependency 'bcrypt', '~> 3.1.7'
  spec.add_runtime_dependency 'rails-i18n', '~> 4.0'
  spec.add_runtime_dependency 'inherited_resources', '~> 1.5'
  spec.add_runtime_dependency 'cancancan', '~> 1.8'
  spec.add_runtime_dependency 'google-api-client', '0.7.1'
  spec.add_runtime_dependency 'faker', '~> 1.3.0'
  spec.add_runtime_dependency 'font-awesome-rails', '~> 4.1.0'
  spec.add_runtime_dependency 'koala', '1.9.0'
  spec.add_runtime_dependency 'twitter', '5.11.0'
  spec.add_runtime_dependency 'omniauth-twitter', '1.0.1'
  spec.add_runtime_dependency 'instagram', '1.1.1'

  spec.add_development_dependency 'jquery-rails', '~> 3.0.0'
  spec.add_development_dependency 'turbolinks', '~> 2.2.2'

  spec.add_development_dependency 'sqlite3', '~> 1.3.9'
  spec.add_development_dependency 'minitest', '~> 5.3.5'
  spec.add_development_dependency 'minitest-emoji', '2.0.0'
  spec.add_development_dependency 'minitest-capybara', '~> 0.7.1'
  # spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'poltergeist', '~> 1.5.1'
end
