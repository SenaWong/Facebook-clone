class CreateStatuses < ActiveRecord::Migration

	def change
		create_table :statuses do |s|
			s.integer :user_id
			s.string :content, :limit => 140, null: false

			s.timestamps null: false
		end
	end


end