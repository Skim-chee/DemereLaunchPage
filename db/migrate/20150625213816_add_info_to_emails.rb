class AddInfoToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :name, :string
    add_column :emails, :zipcode, :integer
  end
end
