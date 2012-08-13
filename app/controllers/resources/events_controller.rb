class Resources::EventsController < ApplicationController
	before_filter :verify_changed_password
	before_filter :authenticate_someone, :except => [:index, :show]

	layout 'resources'
	
  def index
  	@current_events = Event.find_current
    @past_events = Event.find_past
    @upcoming_events = Event.find_upcoming
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    if @event.member.nil?
    	redirect_to "/resources/events", :notice => 'Members can only edit their own events.'
    else
		  if current_admin || @event.member.id == current_member.id
		  	render :view => "edit"
		  else
		  	redirect_to "/resources/events", :notice => 'Members can only edit their own events.'
		  end
		end
  end

  def create
    @event = Event.new(params[:event])
    
    if @event.save
      redirect_to([:resources, @event], :notice => 'Event was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to([:resources, @event], :notice => 'Event was successfully updated.')      
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to(resources_events_url)
  end
end