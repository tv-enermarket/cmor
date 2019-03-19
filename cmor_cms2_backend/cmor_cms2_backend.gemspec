$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cmor_cms2_backend'
  s.version     = Cmor::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://github.com/robotex82/cmor_cms2_backend'
  s.summary     = 'Backend Module for ECM CMS 2'
  s.description = 'Provides a ITSF Backend based Backend for ECM CMS 2'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails'
  s.add_dependency 'cmor_core_backend'
  s.add_dependency 'cmor_cms2'
  # s.add_dependency 'rails-i18n'
  # s.add_dependency 'route_translator'
  # s.add_dependency 'coffee-rails'
  # s.add_dependency 'jquery-rails'

  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'i18n-debug'
  s.add_development_dependency 'jquery-turbolinks'

  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rails'
end
