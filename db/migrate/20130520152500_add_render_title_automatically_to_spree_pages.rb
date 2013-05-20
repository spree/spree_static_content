class AddRenderTitleAutomaticallyToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :render_title_automatically, :boolean, :default => true
    execute "UPDATE spree_pages SET render_title_automatically = true;"
  end
end
