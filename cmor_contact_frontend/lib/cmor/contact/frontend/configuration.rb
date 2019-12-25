require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Contact
    module Frontend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :input_name_css_classes do
          'form-control'
        end

        mattr_accessor :input_email_css_classes do
          'form-control'
        end

        mattr_accessor :input_phone_css_classes do
          'form-control'
        end

        mattr_accessor :input_message_css_classes do
          'form-control'
        end

        mattr_accessor :input_terms_of_service_css_classes do
          ''
        end

        mattr_accessor :form_actions_wrapper_css_classes do
          'controls form-actions well'
        end

        mattr_accessor :base_controller do
          'ApplicationController'
        end

        mattr_accessor :additional_contact_information do
          nil
        end

        mattr_accessor :after_create_url do
          ->(controller) { controller.root_path }
        end
      end
    end
  end
end
