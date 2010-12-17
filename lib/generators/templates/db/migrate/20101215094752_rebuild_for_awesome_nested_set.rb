class RebuildForAwesomeNestedSet < ActiveRecord::Migration
  def self.up
    Page.rebuild! rescue puts("Rebuild skipped")
  end

  def self.down
  end
end
