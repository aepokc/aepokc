class PagesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:db, :mail, :show, :home, :application, :holiday]
  before_filter :authenticate_someone, :only => [:db]
  layout 'admin'
  
  def holiday
    render :layout => false
#    redirect_to 'http://aepokc.eventbrite.com'
  end
  
  def db
    if !current_admin && current_member.leader == false
      redirect_to members_profiles_directory_path
    else
      members = Member.count
      @progress = Payment.current_count/members.to_f*100
      @members = Member.order("lastname")
      @member_count = members
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
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    
    if @page.save
      redirect_to([@page], :notice => 'Page was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(params[:page])
      redirect_to([@page], :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    redirect_to(pages_url)
  end
end