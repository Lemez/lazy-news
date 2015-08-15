class UserMailer < ActionMailer::Base
	default from: "lemez9@gmail.com"

  	def weekly_email(user)
  		@user = user
	    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).where.not(source: "rollingstone").order(:modified).order(source: :desc).reverse
   		@genre = 'music'
   		@companies = Startup.order(:modified).reverse[0..4]
   		@names = {'musically' => 'Music Ally', 'cmu' => 'Complete Music Update', 'rollingstone' => 'Rolling Stone', 'musicbusinessworldwide' => 'Music Business Worldwide', 'wired' => 'WIRED', 'mit' => 'MIT Technology Review'}

   		mail(to: @user.email, subject: "Lazy Music News")
  	end
end

