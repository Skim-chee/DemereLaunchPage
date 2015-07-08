class AddVisited < ActiveRecord::Migration
  def change
    add_column :emails, :visited, :boolean, :default => false
  end
end
