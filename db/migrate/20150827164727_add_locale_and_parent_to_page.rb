class AddLocaleAndParentToPage < ActiveRecord::Migration
  def change
    add_column :spree_pages, :locale, :string
    add_column :spree_pages, :parent_id, :integer
  end
end
