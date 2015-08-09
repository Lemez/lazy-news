class UserMailer < ActionMailer::Base
	include Roadie::Rails::Automatic
	default from: "lemez9@gmail.com"

  	def weekly_email(user)
	    @useremail = "lemez9@gmail.com"
	    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).order(:modified).order(source: :desc).reverse
   		@genre = 'music'
	    roadie_mail (to: @useremail, subject: subject_for_user(@genre)) do |format|]

	    	format.html { render layout: 'mailer_layout' }
	      	format.text

  	end

	private
		def subject_for_user(user)
			I18n.translate 'emails.weekly_email.subject', name: @name
		end
	end
end

