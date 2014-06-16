class Contract < ActiveRecord::Base
	belongs_to :user
	belongs_to :task
	has_many :goals, dependent: :destroy
	has_many :reports, dependent: :destroy

	def self.init(finish_date, tasks, levels, goals, user_id)
		# raise
		contracts = []
		tasks.each do |task_id|
	      task = Task.find(task_id)
	      contracts << Contract.create(finish_date: finish_date, 
	                               task_id: task_id, 
	                               user_id: user_id)
	      task.levels.each do |level| 
	        goal = Goal.create(initial: levels.shift, 
	                           target: goals.shift,
	                           level_id: level.id,
	                           contract_id: contracts.last.id)
	        logger.debug "HELLO INITIAL GOAL"
	        logger.debug(goal.initial)
	        logger.debug "HELLO GOALS"
	        logger.debug(goals)
	      end
	      # @report = Report.new
	      # @contract.report = @report
	    end
	    contracts
	end
end
