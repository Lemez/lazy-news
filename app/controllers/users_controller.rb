class UsersController < ApplicationController

	def new
		@user = User.new
		@companies = Startup.order(:modified).reverse[0..4]
	    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).where.not(source:'rollingstone').order(:modified).order(source: :desc).reverse
	    @genre = 'music'
	end

	def create

		begin
			user = User.where(params[:user]).first_or_create!

			if user.persisted?
		  		flash[:notice] = "Thanks for signing up! You are User ##{user.id}"

		  		UserMailer.weekly_email(user).deliver

		  		@user = User.new
		  		redirect_to new_user_path, notice: flash[:notice]
		  		return
			
	  		else
	 			flash[:notice] = "That user already exists! Please check your inbox."

	 			@user = User.new
	 			redirect_to new_user_path, notice: flash[:notice]
	 			return

	 		end	

	 	rescue

	 		flash[:notice] = "Your email is invalid, please check and try again."
	 		p "STRANGE"
	 		@user = User.new
	 		redirect_to new_user_path, notice: flash[:notice]
	 		return

	 	end
	end
end
