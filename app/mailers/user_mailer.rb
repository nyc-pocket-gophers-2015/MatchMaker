class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def invite_email(email)
    @url  = 'http://dbcmatchme.herokuapp.com/'
    mail(to: email, subject: "You've been invited to join MatchMe")
  end
end
