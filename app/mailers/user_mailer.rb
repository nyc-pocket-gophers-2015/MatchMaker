class UserMailer < ApplicationMailer
   default from: 'notifications@example.com'

  def invite_email(email)
    @url  = 'http://example.com/login'
    mail(to: email, subject: "You've been invited to join MatchMe")
  end
end
