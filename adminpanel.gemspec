# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adminpanel/version'

Gem::Specification.new do |spec|
  spec.name          = "adminpanel"
  spec.version       = Adminpanel::VERSION
  spec.authors       = ["Jose Ramon Camacho"]
  spec.email         = ["joserracamacho@gmail.com"]
  spec.description   = %q{Gem that makes the admin panel for a site a breeze!}
  spec.summary       = %q{Developed with love for ruby 1.8.7}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "app/assets"]


  spec.add_dependency "rails", "3.2.12"
  spec.add_dependency "carrierwave", "0.9.0"
  spec.add_dependency "rmagick", "2.13.2"
  spec.add_dependency "ckeditor", "4.0.6"
  spec.add_dependency "jquery-rails", "3.0.4"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
