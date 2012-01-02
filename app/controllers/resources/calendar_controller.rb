class Resources::CalendarController < ApplicationController
	before_filter :verify_changed_password
	layout 'resources'
	
	def show
    @events = Event.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end 
end