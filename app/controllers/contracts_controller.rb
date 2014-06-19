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
      @charts = []
      @averages = []
      @recents = []
      @progress = []
      @contracts.each do |contract| 
        @charts << line_chart(contract)
        @averages << Contract.average(contract)
        @recents << Contract.recent(contract)
        @progress << get_recent_colour(contract)
      end

      
    end
  end

  def get_recent_colour(contract)
    avg = Contract.recent(contract)
    if avg == "-"
      return "" 
    elsif avg <= contract.target     
      return "green"
    else
      "red"
    end
  end

  def column(n) 
    "col-md-" + (12/n).to_s
  end

  def check_params 
    poss = [:category, :task, :level, :benchmark, :goal, :finish_date]
    found = false
    params.has_key?(poss[session[:step]-1])
  end

  def new
    if !check_params
      session[:step] = 0
    end

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

      session[:level] = params[:level]
      @level = Level.find(session[:level])
      session[:step] = 4
      
    elsif session[:step] == 4

      @level = Level.find(session[:level])
      session[:initial] = params[:benchmark]
      session[:step] = 5

    elsif session[:step] == 5

      @level = Level.find(session[:level])
      session[:target] = params[:goal]
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

  def line_chart(contract)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')
    data_table.new_column('number', 'Goal')
    data_table.new_column('number', 'Reported')
    data_table.add_rows(contract.reports.count)

    delta = (contract.initial - contract.target).to_f/contract.reports.count
    # binding.pry
    contract.reports.each_with_index do |report, index|
      data_table.set_cell(index, 0, report.created_at.to_date)   
      data_table.set_cell(index, 1, (contract.initial.to_f - delta * index).round(1))
      data_table.set_cell(index, 2, report.value)   
    end

    v_title = contract.level.name.capitalize + " (" + contract.level.unit + ")"  

    opts   = { :width => 550, :height => 240, hAxis: {title: 'Report Date'}, vAxis: {title: v_title} } 
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, opts)

  end
  
end
