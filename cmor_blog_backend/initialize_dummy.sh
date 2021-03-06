#!/bin/bash
BACKEND_GEM_NAME=${PWD##*/}
BACKEND_INSTALL_NAME=${BACKEND_GEM_NAME//cmor_/cmor\:}
BACKEND_INSTALL_NAME=${BACKEND_INSTALL_NAME//_backend/\:backend}
GEM_NAME=${BACKEND_GEM_NAME//_backend/}
INSTALL_NAME=${BACKEND_INSTALL_NAME//\:backend/}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app
rm spec/dummy/.ruby-version

# Satisfy prerequisites
cd spec/dummy

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Add ActiveStorage
rails active_storage:install:migrations

# Add User model for userstamping
rails g model User email
sed -i '2i\  private' app/controllers/application_controller.rb
sed -i '3i\  ' app/controllers/application_controller.rb
sed -i '4i\  def current_user' app/controllers/application_controller.rb
sed -i '5i\    User.first_or_create!(email: "jane.doe@domain.local")' app/controllers/application_controller.rb
sed -i '6i\  end' app/controllers/application_controller.rb

# Install cmor core backend gem
rails generate administrador:install
rails generate cmor:core:backend:install

# Install frontend gem
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare

# Install
rails generate $BACKEND_INSTALL_NAME:install