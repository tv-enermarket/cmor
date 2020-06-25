# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Backend::Gemspec.defaults(spec)
  spec.name        = "cmor_transports"
  spec.summary     = "Cmor::Transports Module."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'aasm'
  spec.add_dependency 'rao-service'
  spec.add_dependency 'rubyzip'
  spec.add_dependency 'httparty'
  spec.add_dependency 'rao-api-service_controller'

  spec.add_development_dependency "bootsnap"
  spec.add_development_dependency "turbolinks"
  spec.add_development_dependency "cmor_cms"
  spec.add_development_dependency "cmor_cms_backend"
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'puma'
end