require 'spree_core'
require 'spree_static_content/engine'
require 'coffee_script'
require 'sass/rails'

module StaticPage
  def self.remove_spree_mount_point(path)
    regex = Regexp.new '\A' + Rails.application.routes.url_helpers.spree_path
    path.sub( regex, '').split('?')[0]
  end

  def self.remove_spree_mount_point_if_exists(path)
    spree_path = Rails.application.routes.url_helpers.spree_path
    if spree_path == "/"
      return path
    else
      return remove_spree_mount_point(path)
    end
  end
end

class Spree::StaticPage
  def self.matches?(request)
    return false if request.path =~ /(^\/+(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+)/
    !Spree::Page.visible.find_by_slug(::StaticPage.remove_spree_mount_point_if_exists(request.path)).nil?
  end
end
