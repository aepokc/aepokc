class Resources::CalendarController < ApplicationController
	before_filter :verify_changed_password
	layout 'resources'
  
	def verify_changed_password
		if member_signed_in?
			unless current_member.random_password == 'replaced'
				redirect_to '/members/edit', :notice => 'You must replace your temporary password before proceeding.'
			end
		else
		end
  end  
	
	def show
    @events = Event.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end 
end