class UserMailer < ActionMailer::Base
  default from: "info@loraction.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'zchauvin@college.harvard.edu', subject: 'Welcome to My Awesome Site')
  end

  def report_email(user, contract)
  	@user = user
  	@url = 'http://agile-savannah-3773.herokuapp.com/'
  	@contract = contract
  	mail(to: @user.email, subject: 'Report ')
  end
end
