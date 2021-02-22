require 'spree_core'
require 'spree_static_content/engine'
require 'spree_static_content/version'
require 'spree_extension'

module StaticPage
  module_function

  def remove_spree_mount_point(path)
    regex = Regexp.new '\A' + Rails.application.routes.url_helpers.spree_path
    path.sub(regex, '').split('?')[0]
  end
end

module Spree
  class StaticPage
    def self.matches?(request)
      locales = I18n.available_locales.join('|')
      path_regex = %r{\A/+(api/v|api_tokens|admin|account|cart|checkout|content|login|pg/|orders|products|s/|session|signup|shipments|states|t/|tax_categories|user|rails/active_storage|#{locales})+}
      return false if request.path =~ path_regex

      finder_scope.exists?(slug: request.path)
    end

    def self.finder_scope
      Spree::Page.visible
    end
  end
end
