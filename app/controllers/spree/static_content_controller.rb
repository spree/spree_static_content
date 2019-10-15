module Spree
  class StaticContentController < StoreController
    helper 'spree/products'
    layout :determine_layout

    def show
      @page = Spree::StaticPage.finder_scope.by_store(current_store).find_by!(slug: [params[:path], "/#{params[:path]}"])
    end

    private

    def determine_layout
      return @page.layout if @page && @page.layout.present? && !@page.render_layout_as_partial?
      Spree::Config.layout
    end

    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
  end
end
