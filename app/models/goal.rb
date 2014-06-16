class Goal < ActiveRecord::Base
	belongs_to :contract
	belongs_to :level
	has_many :report_fields
end
