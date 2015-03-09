class InfoController < ApplicationController

	def home
	end

	def itinerary
		render :layout => "delegate_dashboard"
	end

end
