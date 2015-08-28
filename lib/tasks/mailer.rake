namespace :mailer do

	task :send_weekly_mail => :environment do
		  UserMailer.weekly_email(1).deliver
	end

end

