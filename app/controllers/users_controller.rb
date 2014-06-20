class UsersController < ApplicationController
	before_action :authenticate_user!, :except => []

	def index
	end

	def show 
		@user = User.find(params[:id])
		@report_count = 0
		current_user.contracts.each do |contract|
			@report_count += contract.reports.count
		end
		@water_saved = 254
	end
end
