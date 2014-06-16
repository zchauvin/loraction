class Level < ActiveRecord::Base
	belongs_to :task
	has_many :goals
end
