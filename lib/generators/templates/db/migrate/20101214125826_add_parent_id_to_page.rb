class AddParentIdToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :parent_id, :integer
    add_column :pages, :lft, :integer
    add_column :pages, :rgt, :integer

    add_index :pages, :parent_id
  end

  def self.down
    remove_column :pages, :parent_id
  end
end
