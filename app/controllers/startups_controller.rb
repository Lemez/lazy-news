class StartupsController < ApplicationController
	def index
		@startups = Startup.all.order(:modified).reverse
	end
end
