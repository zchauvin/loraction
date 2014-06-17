class ReportsController < ApplicationController
	def create
		@report = Report.new(contract_id: params[:contract], value: params[:value])
		if @report.save
	      flash[:notice] = "Report created successfully!"
	    else 
	      flash[:error] = @contract.errors.full_messages.join(" | ")
	    end
	end
end
