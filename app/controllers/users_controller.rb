class UsersController < ApplicationController

	def new
		@user = User.new
		@companies = Startup.order(:modified).reverse[0..4]
	    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).order(:modified).order(source: :desc).reverse
	    @genre = 'music'
	end

	def create
		@user = User.where(params[:user]).first_or_create
		if @user.save
      		flash[:notice] = "Thanks for signing up!"
      		# Sends email to user when user is created.
      		UserMailer.weekly_email(@user).deliver
      		p "++++++++++ DELIVERED++++++++++++"
		else
     		flash[:alert] = "Something is wrong :("
     			p "++++++++++ no++++++++++++"
	 	end
	 	redirect_to root_path
	 end
end
