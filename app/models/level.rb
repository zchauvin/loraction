class Level < ActiveRecord::Base
	belongs_to :task
	has_many :contracts
	has_many :tips

	def self.time_to_int(time)
		case time
		when "day"
			1
		when "week"
			7
		else 
			30
		end
	end
end
