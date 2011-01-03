class PagesController < ApplicationController

	before_filter :authenticate_admin!, :except => [:db, :mail, :show, :home, :application]
	before_filter :authenticate_member!, :only => [:db]
	layout 'admin'
	
	def db
		if current_member.leader == false
			redirect_to members_profiles_directory_path
		else
			@members = Member.order("lastname")
			@member_count = Member.count
			@confirmed_count = Member.where(:confirmation_token => nil).count
			@profile_count = Profile.count
			
			render :layout => false
		end
	end
  
	def show
		if params[:link]
		  @page = Page.find_by_link(params[:link])
		  raise ActiveRecord::RecordNotFound, "Page not found" if @page.nil?
		else
		  @page = Page.find(params[:id])
		end
		render :layout => 'application'
  end
  
  def home
    @feed_events = Event.find_feed
   	render :layout => false
  end
  
  def mail
   	render :layout => false
  end
  
  def admin
  end
  
  def application
  end
  
  def index
    @pages = Page.find_parents
    @subpages = Page.find_subpages

    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
    end
  end

  def new
    @page = Page.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to([@page], :notice => 'Page was successfully created.') }
        format.xml  { render :xml => [@page], :status => :created, :location => [@page] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to([@page], :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
end
