class Task < ActiveRecord::Base
	belongs_to :category
	has_many :levels, dependent: :destroy
	has_many :tips
	has_many :contracts
end
