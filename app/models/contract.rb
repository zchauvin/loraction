class Contract < ActiveRecord::Base
	belongs_to :user
	belongs_to :level
	has_many :reports, dependent: :destroy
	# has_one :task, through: :level
	# has_one :category, through: :task

	def self.average(contract)
		arr = contract.reports.map { |r| r.value }
		if arr.empty? 
			return "-"
		end
		(arr.inject(0.0) { |sum, el| sum + el } / arr.size).round(1)
	end

	def self.recent(contract)
		arr = contract.reports.map { |r| r.value }
		if arr.size < 3
			return "-"
		else		
			arr = arr.last(3)
			(arr.inject(0.0) { |sum, el| sum + el } / arr.size).round(1)
		end
	end
end
