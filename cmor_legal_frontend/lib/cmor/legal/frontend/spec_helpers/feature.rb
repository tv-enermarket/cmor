module Cmor
  module Legal
    module Frontend
      module SpecHelpers
        module Feature
          def accept_eu_gdpr_cookies
            if has_css?('#cmor-legal-cookies-accept')
              find('#cmor-legal-cookies-accept').click
            else
              puts "WARNING: Could not accept EU GDPR Cookies as the consent button ('#cmor-legal-cookies-accept') was not found."
            end
          end
        end
      end
    end
  end
end
