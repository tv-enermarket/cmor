# frozen_string_literal: true

require "factory_bot_rails"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.tap do |f|
  f.factories.clear
  f.definition_file_paths += [
    Cmor::Seo::Engine.root.join(*%w(spec factories)),
    Rails.root.join(*%w(spec factories))
  ]
  f.find_definitions
end
