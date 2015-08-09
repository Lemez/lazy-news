class UserController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user]) 
		if @user.save
      		@flash[:success] = "Thanks for signing up!"
		else
     		@flash[:failure] = "Something is wrong :("
	 	end
	 end
end
