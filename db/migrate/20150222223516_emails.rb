class Emails < ActiveRecord::Migration
  def change
  	create_table :emails do |t|
  		t.string :email
  		t.boolean :activated
  		t.integer :position
  		t.string :email_confirm_token
  	end
  end
end
