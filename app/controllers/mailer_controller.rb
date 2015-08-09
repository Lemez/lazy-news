class MailerController < ApplicationController

  def preview_welcome
    @stories = Story.is_music.where(:modified => 1.week.ago..Time.now).order(:modified).order(source: :desc).reverse
    @genre = 'music'
    render :file => 'mailer/weekly_email.html.erb', :layout => 'mailer_layout'
  end

end