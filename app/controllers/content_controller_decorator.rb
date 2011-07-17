ContentController.class_eval do
  private

  def accurate_title
    if @page.respond_to?("meta_title")
      @page ? @page.meta_title : nil
    else
      @page ? @page.title : nil
    end
  end

end