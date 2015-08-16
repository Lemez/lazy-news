# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
News::Application.initialize!

#  http://stackoverflow.com/questions/12180690/set-logging-levels-in-ruby-on-rails
ActiveRecord::Base.logger.level = 2
