module Spree::PagesHelper
  def render_snippet(slug)
    page = Spree::Page.find_by(slug: slug)
    raw page.body if page
  end

  def page_uri page
    path = Rails.application.routes.named_routes[:spree].path.spec.to_s
    page_uri = path == '/' ? page.slug : path + page.slug
  end

  def page_li_class page
    path = request.fullpath.gsub('//','/')
    "current" if path == page_uri(page)
  end
end
