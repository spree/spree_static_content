# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_static_content/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_static_content'
  s.version     = SpreeStaticContent.version
  s.summary     = 'Extention to manage the static pages for your Spree shop.'
  s.description = s.summary
  s.required_ruby_version = '>= 2.5.0'

  s.authors      = ['Peter Berkenbosch', 'Roman Smirnov']
  s.email        = 'peter@pero-ict.nl'
  s.homepage     = 'https://github.com/spree-contrib/spree_static_content'
  s.license      = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 3.7.0', '< 5.0'
  s.add_dependency 'spree_backend', '>= 3.7.0', '< 5.0'
  s.add_dependency 'spree_extension'
  s.add_dependency 'deface', '~> 1.5'

  s.add_development_dependency 'spree_dev_tools'
end
