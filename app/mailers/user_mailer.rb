class UserMailer < ActionMailer::Base
  default from: "info@loraction.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'zchauvin@college.harvard.edu', subject: 'Welcome to My Awesome Site', from: "info@loraction.com")
  end

  def report_email(user, contract)
  	@recent = 8.3
    r = rand(contract.level.tips.count)
    @tip = contract.level.tips[r]
    @user = user
  	@url = 'http://agile-savannah-3773.herokuapp.com/reports'
  	@contract = contract
  	mail(to: @user.email, 
  		 subject: "Report for #{@contract.level.task.name} #{@contract.level.name} on #{Date.today.strftime("%B %e, %Y")}", 
  		 from: "info@loraction.com")
  end
end
