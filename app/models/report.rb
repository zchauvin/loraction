class Report < ActiveRecord::Base
	has_many :report_fields, dependent: :destroy
	belongs_to :contract
end
