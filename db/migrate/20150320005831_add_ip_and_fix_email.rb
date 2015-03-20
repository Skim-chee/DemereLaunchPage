class AddIpAndFixEmail < ActiveRecord::Migration
  def change
  	create_table :ip_addresses do |t|
  		t.string :address
  		t.integer :count
  	end

  	change_table :emails do |t|
  		t.string   :referral_code
    	t.integer  :referrer_id
  	end

  	drop_table :users
  end
end
