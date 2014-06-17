class Contract < ActiveRecord::Base
	belongs_to :user
	belongs_to :level
	has_many :reports, dependent: :destroy
	# has_one :task, through: :level
	# has_one :category, through: :task
end
