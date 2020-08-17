module Cmor
  module Cms
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Cms
      
      config.app_generators do |c|
        c.test_framework :rspec, fixture: true,
                                 fixture_replacement: nil

        c.integration_tool :rspec
        c.performance_tool :rspec

      end

      initializer "cmor_cms_engine.register_template_handlers" do |app|
        ::ActionView::Template.register_template_handler :textile, ::ActionView::Template::Handlers::Textile.new
      end

      initializer "cmor_cms_engine.add_redirect_middleware" do |app|
        app.middleware.use Cmor::Cms::RedirectMiddleware
      end
    end
  end
end
