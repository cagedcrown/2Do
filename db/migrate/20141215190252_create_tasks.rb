class CreateTasks < ActiveRecord::Migration
	def change
		create_table :tasks do |t|
			t.string :title, null: false
			t.text :description, default: ""
			t.integer :list_id
			t.integer :user_id

			t.timestamps
		end
	end
end