$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core/lib/cmor/core/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Gemspec.defaults(s)
  s.name        = 'cmor_blog'
  s.summary     = 'Cmor::Blog.'
  s.description = 'Cmor::Blog Module.'

  s.files = Dir['{app,config,db,lib,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts_as_published'
  s.add_dependency 'friendly_id'
  s.add_dependency 'haml-rails'
  s.add_dependency 'kramdown'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'rao-resources_controller', '>= 0.0.16.pre'
  s.add_dependency 'rao-service', '>= 0.0.16.pre'

  s.add_development_dependency 'bootstrap4-kaminari-views'
end
