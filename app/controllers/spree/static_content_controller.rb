class Spree::StaticContentController < Spree::StoreController

  helper "spree/products"
  layout :determine_layout

  def show
    path = case params[:path]
    when Array
      '/' + params[:path].join("/")
    when String
      '/' + params[:path]
    when nil
      request.path
    end

    unless @static_content = Spree::Page.visible.by_slug(path).first
      render_404
    end
  end

  private

  def determine_layout
    return @static_content.layout if @static_content and @static_content.layout.present? and not @static_content.render_layout_as_partial?
    Spree::Config.layout
  end

  def accurate_title
    @static_content ? (@static_content.meta_title.present? ? @static_content.meta_title : @static_content.title) : nil
  end

end
