class Level < ActiveRecord::Base
	belongs_to :task
	belongs_to :contract
	has_many :tips
end
