class Resources::CalendarController < ApplicationController

	layout 'resources'
	
	def show
    @events = Event.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end
    
end
