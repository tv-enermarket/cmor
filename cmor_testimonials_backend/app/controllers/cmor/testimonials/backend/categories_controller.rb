module Cmor
  module Testimonials
    module Backend
      class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Cmor::Testimonials::Category
        end

        private

        def permitted_params
          params.require(:category).permit(:identifier)
        end
      end
    end
  end
end