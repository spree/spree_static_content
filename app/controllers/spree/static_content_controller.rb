class Spree::StaticContentController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  helper 'spree/products'
  helper 'spree/pages'

  layout :determine_layout

  def show
    @page = Spree::Page.visible.find_by!(slug: request.path)
  end

  private

  def determine_layout
    if @page && @page.layout.present? && !@page.render_layout_as_partial?
      @page.layout
    else
      Spree::Config.layout
    end
  end
end
