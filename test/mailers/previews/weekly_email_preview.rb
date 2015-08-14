# Preview all emails at http://localhost:3000/rails/mailers/example_mailer

class UserMailerPreview < ActionMailer::Preview
  def weekly_email_preview
    UserMailer.weekly_email(User.first)
  end
end