class UsersController < ApplicationController

	def new
		@user = User.new
		@companies = Startup.order(:modified).reverse[0..4]
	    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).order(:modified).order(source: :desc).reverse
	    @genre = 'music'
	end

	def create
		@user = User.new(params[:user]) 
		if @user.save
      		flash[:success] = "Thanks for signing up!"
      		#  send the welcome mail
		else
     		flash[:error] = "Something is wrong :("
	 	end
	 	redirect_to root_path
	 end
end
