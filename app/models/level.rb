class Level < ActiveRecord::Base
	belongs_to :task
	has_many :contracts
	has_many :tips
end
