class Resources::EventsController < ApplicationController

	before_filter :verify_changed_password  
  
	def verify_changed_password
		if member_signed_in?
			unless current_member.random_password == 'replaced'
				redirect_to '/members/edit', :notice => 'You must replace your temporary password before proceeding.'
			end
		else
		end
	end
	
	before_filter :authenticate_member!, :except => [:index, :show]

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
		  if @event.member.id == current_member.id
		  	render :view => "edit"
		  else
		  	redirect_to "/resources/events", :notice => 'Members can only edit their own events.'
		  end
		end
  end

  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to([:resources, @event], :notice => 'Event was successfully created.') }
        format.xml  { render :xml => [:resources, @event], :status => :created, :location => [:resources, @event] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to([:resources, @event], :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(resources_events_url) }
      format.xml  { head :ok }
    end
  end
end
