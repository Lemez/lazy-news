class MailerController < ApplicationController

  def preview_welcome
  	@companies = Startup.order(:modified).reverse[0..4]
	@stories = Story.is_music.where(:modified => 1.week.ago..Time.now).where.not(source:'rollingstone').order(:modified).order(source: :desc).reverse
    @genre = 'music'
    render :file => 'user_mailer/weekly_email.html.erb', :layout => 'mailer_layout'
  end

end