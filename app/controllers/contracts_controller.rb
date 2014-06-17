class ContractsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    # UserMailer.welcome_email(User.first).deliver
    session[:step] = 0
    if !user_signed_in?
      render 'intro/index.html.erb', layout: "intro_layout"
    elsif current_user.contracts.empty? 
  		redirect_to new_contract_path
  	else 
      @contracts = Contract.where(user_id: current_user.id)
    end
    # if !user_signed_in?
    #   @user =
    # else 

    # end
      


  end

  def new
    if session[:step] == 0
      @categories = Category.all
      session[:step] = 1
    elsif session[:step] == 1

      @tasks = Category.find(params[:category]).tasks
      session[:step] = 2

    elsif session[:step] == 2
      
      task = Task.find(params[:task])
      @levels = task.levels  
      session[:step] = 3

    elsif session[:step] == 3

      @level = Level.find(params[:level])
      session[:level] = params[:level]
      session[:step] = 4
      
    elsif session[:step] == 4
      
      @level = Level.find(session[:level])
      session[:initial] = params[@level.name]
      session[:step] = 5

    elsif session[:step] == 5

      @level = Level.find(session[:level])
      session[:target] = params[@level.name]
      session[:step] = 6

    else 
      @contract = Contract.new(
        finish_date: params[:finish_date], 
        initial: session[:initial],
        target: session[:target],
        user_id: current_user.id,
        level_id: session[:level]
      )
      @level = Level.find(session[:level])
      @contract.level = @level
      @tips = @level.tips
      if @contract.save 
        flash[:notice] = "Contract created successfully!"
      else 
        flash[:error] = @contract.errors.full_messages.join(" | ")
      end
      UserMailer.report_email(current_user, @contract).deliver
      render 'create'
    end
  end

  def report
    newReport = Report.create
    @contract = Contract.find(params[:contract_id])
    @contract.goals.each do |goal|
      if params.has_key?(goal.level.name)
        newReport.report_fields << ReportField.create(value: params[goal.level.name], goal_id: goal.id)
      end
    end
    @contract.reports << newReport
    @contracts = Contract.where(user_id: current_user.id)
    render 'index'
  end

  def create
  end

  def show
  end
end
