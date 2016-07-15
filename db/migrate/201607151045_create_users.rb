require 'bcrypt'

class CreateUsers < ActiveRecord::Migration

	def change
		create_table :users do |u|
			u.string :name, null: false
			u.string :user_email, null: false
			u.string :password_digest, null: false

			u.timestamps null: false
		end
	end
end