module Cmor::Partners::Frontend
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Partners::Frontend::ApplicationViewHelper, as: :partners_helper
    #     end
    #
  class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/layouts/application.html.haml
      #     = partners_helper(self).render_partners(category_identifier)
      #
    def render_partners(category_or_identifier, options = {})
      options.reverse_merge!(center_mode: true, slides_to_show: 6, autoplay: true,
        variant_options: Cmor::Partners::Frontend::Configuration.default_render_partners_variant_options)
      variant_options = options.delete(:variant_options)
      category = if category_or_identifier.is_a?(Cmor::Partners::Category)
        category_or_identifier
      else
        Cmor::Partners::Category.where(identifier: category_or_identifier).first
      end

      if category.present?
        render category: category, options: options, variant_options: variant_options
      end
    end
  end
end