class RebuildForAwesomeNestedSet < ActiveRecord::Migration
  def self.up
    Page.rebuild!
  end

  def self.down
  end
end
