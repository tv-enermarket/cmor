module Cmor
  module Cms
    module DatabaseResolver
      # Include hook for class methods
      def self.included(base)
        base.extend(ClassMethods)
      end

      # class methods go here
      module ClassMethods
        def caching
          Cmor::Cms::Configuration.resolver_caching.call
        end
      end

      # instance methods go here
      def find_templates(name, prefix, partial, details, outside_app_allowed = false)
        return [] unless resolve(partial)

        conditions = {
          pathname: assert_slashs(prefix.to_s),
          basename: normalize_basename(name),
          locale: normalize_array(details[:locale]).first,
          format: normalize_array(details[:formats]).first,
          handler: normalize_array(details[:handlers])
        }

        format = conditions.delete(:format)
        locale = conditions.delete(:locale)

        query  = template_class.constantize.where(conditions)

        # 2) Check for templates with the given format or format is nil
        query = query.where(["format = ? OR format = '' OR format IS NULL", format])

        # 3) Ensure templates with format come first
        query = query.order('format DESC')

        # 4) Check for templates with the given locale or locale is nil
        query = query.where(["locale = ? OR locale = '' OR locale IS NULL", locale])

        # 5) Ensure templates with locale come first
        query = query.order('locale DESC')

        # 6) Now trigger the query passing on conditions to initialization
        query.map do |record|
          initialize_template(record, details)
        end
      end

      # Initialize an ActionView::Template object based on the record found.
      if Rails.version < '6.0'
        def initialize_template(record, details)
          source     = build_source(record)
          identifier = "#{record.class} - #{record.id} - #{record.pathname}#{record.basename}"
          handler    = ::ActionView::Template.registered_template_handler(record.handler)

          # 5) Check for the record.format, if none is given, try the template
          # handler format and fallback to the one given on conditions
          format   = record.format && Mime[record.format]
          format ||= handler.default_format if handler.respond_to?(:default_format)
          format ||= details[:formats]
          details = {
            format: format,
            updated_at: record.updated_at,
            virtual_path: "#{record.pathname}#{record.basename}"
          }

          details[:layout] = record.layout if record.respond_to?(:layout) && record.layout.present?

          ::ActionView::Template.new(source, identifier, handler, details)
        end
      else
        def initialize_template(record, details)
          source       = build_source(record)
          identifier   = "#{record.class} - #{record.id} - #{record.pathname}#{record.basename}"
          handler      = ::ActionView::Template.registered_template_handler(record.handler)
          virtual_path = "#{record.pathname}#{record.basename}"
          layout = record.layout if record.respond_to?(:layout) && record.layout.present?
          locals       = []

          # 5) Check for the record.format, if none is given, try the template
          # handler format and fallback to the one given on conditions
          format   = record.format && Mime[record.format]
          format ||= handler.default_format if handler.respond_to?(:default_format)
          format ||= details[:formats]

          ::ActionView::Template.new(source, identifier, handler, format: format.symbol, virtual_path: virtual_path, layout: layout, locals: locals)
        end
      end

      def assert_slashs(prefix)
        output = prefix.dup
        output << '/' unless output.end_with?('/')
        output = '/' << output unless output.start_with?('/')
        output
      end

      # Normalize arrays by converting all symbols to strings.
      def normalize_array(array)
        array.map(&:to_s)
      end

      def build_source
        fail 'call to abstract method #build_source'
      end

      def normalize_basename(_basename)
        fail 'call to abstract method #normalize_basename'
      end

      def resolve(_partial_flag)
        fail 'call to abstract method #resolve'
      end

      def template_class
        fail 'call to abstract method #template_class'
      end
    end
  end
end
