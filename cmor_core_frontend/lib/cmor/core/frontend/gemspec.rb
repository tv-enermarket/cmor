module Cmor
  module Core
    module Frontend
      class Gemspec
        def self.defaults(s)
          s.version     = ::Cmor::VERSION
          s.authors     = ["Roberto Vasquez Angel"]
          s.email       = ["roberto@vasquez-angel.de"]
          s.homepage    = "https://github.com/content-management-on-rails"
          s.license     = "MIT"

          s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

          s.add_dependency "rails", ">= 5.2.3"
          # s.add_dependency "cmor", "= #{Cmor::VERSION}"
          s.add_dependency "cmor_core", "= #{Cmor::VERSION}"
          s.add_dependency "cmor_core_frontend", "= #{Cmor::VERSION}" unless s.files.include?("lib/cmor/core/frontend.rb")

          s.add_development_dependency "sqlite3", '~> 1.3.6'
          
          s.add_development_dependency 'capybara'
          s.add_development_dependency 'coveralls'
          s.add_development_dependency 'git_log_generator'
          s.add_development_dependency 'guard-bundler'
          s.add_development_dependency 'guard-rails'
          s.add_development_dependency 'guard-rspec'
          s.add_development_dependency 'pry-rails'
          s.add_development_dependency 'rao-shoulda_matchers'
          s.add_development_dependency 'rails-dummy'
          s.add_development_dependency 'rails-i18n'
          s.add_development_dependency 'rspec-rails'
          s.add_development_dependency 'factory_bot_rails' # This has to be after rspec-rails
          s.add_development_dependency 'rubocop'
          s.add_development_dependency 'rubocop-rails_config'
          s.add_development_dependency 'shoulda-matchers'
          s.add_development_dependency 'simplecov'
          s.add_development_dependency 'simplecov-console'
        end
      end
    end
  end
end
