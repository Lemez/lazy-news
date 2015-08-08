class MailerController < ApplicationController

  def preview_welcome
    @stories = Story.is_music.last_week.order(:modified).reverse
    @genre = 'music'
    render :file => 'mailer/weekly_email.html.erb', :layout => 'mailer_layout'
  end

end