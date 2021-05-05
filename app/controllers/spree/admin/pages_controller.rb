module Spree
  module Admin
    class PagesController < ResourceController
      private

      def collection
        model_class.order(position: :asc)
      end

      def update_page_attribute
        params.require(:page).permit(permitted_params)
      end
    end
  end
end
