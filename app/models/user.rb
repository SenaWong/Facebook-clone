class User < ActiveRecord::Base

	has_secure_password

	validates :user_email, :format => {:with => /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,}\z/i, :message => "Only valid email"} , :uniqueness => true


end