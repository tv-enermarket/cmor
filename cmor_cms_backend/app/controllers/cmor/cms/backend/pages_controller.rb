module Cmor
  module Cms
    module Backend
      class PagesController < Cmor::Core::Backend::ResourcesController::Base
        include Cmor::Transports::ResourcesController::ExportConcern
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::Page
        end

        def self.available_rest_actions
          super + [:export]
        end

        private

        def permitted_params
          params.require(:page)
                .permit(:title, :meta_description, :body, :pathname, :basename, :locale, :format, :handler, :layout, :published, navigation_item_ids: [])
        end
      end
    end
  end
end
