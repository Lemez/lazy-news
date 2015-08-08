class UserMailer < ActionMailer::Base
	include Roadie::Rails::Automatic
	default from: "from@example.com"
	layout 'mailer'

  	def weekly_email(user)
	    @useremail = "jon@jon.com"
	    @stories  = Story.last_week.music
	    @genre = "music"
	    @name = "jon"
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

