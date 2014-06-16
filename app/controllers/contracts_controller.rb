class ContractsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    # UserMailer.welcome_email(User.first).deliver
    session[:accepted_tasks] = []
    session[:levels] = []
    session[:goals] = []
    session[:step] = 0
    if !user_signed_in?
      render 'intro/index.html.erb', layout: "intro_layout"
    elsif current_user.contracts.empty? 
  		redirect_to new_contract_path
  	else 
      @contracts = Contract.where(user_id: current_user.id)
    end
    
  end

  def new
    if session[:step] == 0
      @categories = Category.all
      session[:step] = 1
    elsif session[:step] == 1
      @tasks = Category.find(params[:category]).tasks
      session[:category] = params[:category]
      session[:step] = 2
    elsif session[:step] == 2
      @tasks = Category.find(session[:category]).tasks
      @chosen_tasks = []
      @tasks.each do |task|
        if params.has_key?("#{task.name}_#{task.timescale}".to_sym)
          session[:accepted_tasks] << task.id 
          @chosen_tasks << task 
        end 
      end
      session[:step] = 3

    elsif session[:step] == 3
      
      @chosen_tasks = []
      session[:accepted_tasks].each do |task_id|
        task = Task.find(task_id)
        task.levels.each do |level|
          session[:levels] << params[level.name]
        end
        @chosen_tasks << task 
      end
      session[:step] = 4
      
    elsif session[:step] == 4
      session[:step] = 5
      session[:accepted_tasks].each do |task_id|
        task = Task.find(task_id)
        task.levels.each do |level|
          session[:goals] << params[level.name]
        end
      end
      session[:step] = 5

    else 
      @contracts = Contract.init(params[:finish_date], session[:accepted_tasks], session[:levels], session[:goals], current_user.id)
      @tips = []
      @contracts.each do |contract| 
        contract.task.tips.each do |tip|
          @tips << tip.description
        end
      end
      # if @contract.save 
      #   flash[:notice] = "Contract created successfully!"
      # else 
      #   flash[:error] = @contract.errors.full_messages.join(" | ")
      # end
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
