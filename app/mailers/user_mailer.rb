class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'

    mail(to: @user.e_mail, subject: 'Welcome to My Awesome Site')
  end
end
