$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_frontend/lib/cmor/core/frontend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Frontend::Gemspec.defaults(s)
  s.name        = "cmor_galleries"
  s.summary     = "Cmor Galleries Module."

  s.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "acts_as_list"
  s.add_dependency "acts_as_published"
  s.add_dependency "friendly_id"
  s.add_dependency "rao-resources_controller", '>= 0.0.14.pre'
  s.add_dependency "haml-rails"
end
