class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
		  # We need these attributes for SimpleAuthentication to work
		  t.string :email
		  t.string :hashed_password
		  t.string :salt
		  t.string :username, null: false
		  t.timestamps
		end	

		add_index :users, :email, :unique => true
	end
end