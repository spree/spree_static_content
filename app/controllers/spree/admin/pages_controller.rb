class Spree::Admin::PagesController < Spree::Admin::ResourceController

  def new
    @page = @object
  end

  def edit
    @page = @object
  end

  private
  	def find_resource
      Spree::Page.by_param(params[:id]).first!
    end

end
