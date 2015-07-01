class EditEmails < ActiveRecord::Migration
  def up
    change_column :emails, :zipcode, :string
  end

  def down
    change_column :emails, :zipcode, :integer
  end
end
