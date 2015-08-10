class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user]) 
		if @user.save
      		flash[:notice] = "Thanks for signing up!"
      		#  send the welcome mail
		else
     		flash[:notice] = "Something is wrong :("
	 	end
	 	sleep 5
	 	render "stories#index"
	 end
end
