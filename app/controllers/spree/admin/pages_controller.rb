module Spree
  module Admin
    class PagesController < ResourceController
      def index
        @pages_by_locale = {}
        SpreeI18n::Config.available_locales.each { |locale|
          @pages_by_locale[locale] = Spree::Page.with_locale(locale).root
        }
      end
    end
  end
end
