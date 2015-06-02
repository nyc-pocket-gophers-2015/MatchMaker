class UserMailer < ApplicationMailer
   default from: 'notifications@example.com'

  def invite_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "You've been invited to join MatchMe")
  end
end
