# TO DO: add 'user' ARGV variables below 

namespace :mailer do

	task :send_weekly_mail => :environment do
		  UserMailer.weekly_email(user).deliver
	end

end

