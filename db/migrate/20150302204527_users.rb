class Users < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :email
  		t.string :password_digest
  		t.integer :age
  		t.string :city
  		t.string :state
  		t.string :gender
  		t.string :remember_digest
  		t.string :activation_digest
  		t.boolean :activated
  		t.datetime :activated_at
  	end
  end
end
