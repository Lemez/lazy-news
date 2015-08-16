class UsersController < ApplicationController

	def new
		@users = User.all
		@user = User.new
		@companies = Startup.order(:modified).reverse[0..4]
	    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).where.not(source:'rollingstone').order(:modified).order(source: :desc).reverse
	    @genre = 'music'
	end

	def create

			user = User.where(params[:user]).first_or_initialize

			if not user.valid?
				flash[:notice] = "Your email is invalid, please check and try again."
				redirect_to new_user_path, notice: flash[:notice]
				return

			elsif user.new_record?
				user.save
		  		flash[:notice] = "Thanks for signing up! You are User ##{user.id}"
		  		UserMailer.weekly_email(user).deliver

		  		p "CREATED + SENT"
		  		# @user = User.new
		  		redirect_to new_user_path, notice: flash[:notice]
		  		return
			
	  		else
	 			flash[:notice] = "A user with this email already exists! Please check your inbox."
	 			p "EXISTING"
	 			redirect_to new_user_path, notice: flash[:notice]
	 			return

	 		end	
	end
end
