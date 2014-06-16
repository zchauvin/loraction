class UserMailer < ActionMailer::Base
  default from: "info@loraction.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'zchauvin@college.harvard.edu', subject: 'Welcome to My Awesome Site')
  end
end
