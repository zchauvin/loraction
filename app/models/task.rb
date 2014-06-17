class Task < ActiveRecord::Base
	belongs_to :category
	has_many :levels, dependent: :destroy
end
