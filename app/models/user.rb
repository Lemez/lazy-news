class User < ActiveRecord::Base
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 
				:presence => true,
				:format => { :with => email_regex },
				:uniqueness => { :case_sensitive => false }

	attr_accessible :email
	
end
