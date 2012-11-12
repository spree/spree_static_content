module Spree::PagesHelper
  def render_snippet(slug)
    page = Spree::Page.by_slug(slug).first
    raw page.body if page
  end

  def render_layout_as_partial(slug)
    page = Spree::Page.by_slug(slug).first
    if page && page.render_layout_as_partial == true
      render :partial => page.layout, :locals => {:title => page.title, :body => page.body}
    end
  end
end