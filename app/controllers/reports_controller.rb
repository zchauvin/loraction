class ReportsController < ApplicationController
	def create
		Report.create(contract_id: params[:contract], value: params[:value])
	end
end
