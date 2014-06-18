class ContractsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    # UserMailer.welcome_email(User.first).deliver
    

    scheduler = Rufus::Scheduler.new

    scheduler.in '20s' do
      logger.debug 'Hello... Rufus'
    end

    session[:step] = 0
    if !user_signed_in?
      render 'intro/index.html.erb', layout: "intro_layout"
    elsif current_user.contracts.empty? 
  		redirect_to new_contract_path
  	else 
      @contracts = Contract.where(user_id: current_user.id)
    end
  end

  def column(n) 
    "col-md-" + (12/n).to_s
  end

  def new
    if session[:step] == 0
      @categories = Category.all
      @column = column(Category.count)
      session[:step] = 1
    elsif session[:step] == 1

      
      @tasks = Category.find(params[:category]).tasks
      @column = column(@tasks.count)
      session[:step] = 2

    elsif session[:step] == 2
      
      task = Task.find(params[:task])
      @levels = task.levels  
      @column = column(@levels.count)
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
      level = Level.find(session[:level])
      ts = Level.time_to_int(level.timescale)
      date = Date.today + params[:finish_date].to_i * ts
      @contract = Contract.new(
        finish_date: date, 
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

  def destroy
    @contract = Contract.find(params[:id])
    if @contract.destroy 
      flash[:notice] = "Contract deleted successfully!"
    else 
      flash[:error] = @contract.errors.full_messages.join(" | ")
    end

    redirect_to root_path
  end 


  def create
  end

  def show
  end
end
