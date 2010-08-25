class MembershipApplicationsController < ApplicationController

	layout 'applicants'
	before_filter :authenticate_admin!, :only => [:index]

  def index
    @membership_applications = MembershipApplication.all(:order => 'id DESC')
    @page = Page.find_by_link("membership")
    render :layout => 'admin'
  end

  def show
    @membership_application = MembershipApplication.find(params[:id])
    @page = Page.find_by_link("membership")

    respond_to do |format|
      format.html
      format.xml  { render :xml => @membership_application }
    end
  end

  def new
    @membership_application = MembershipApplication.new
    @page = Page.find_by_link("membership")

    respond_to do |format|
      format.html
      format.xml  { render :xml => @membership_application }
    end
  end

  def create
    @membership_application = MembershipApplication.new(params[:membership_application])
    @page = Page.find_by_link("membership")

    respond_to do |format|
      if @membership_application.save
      	Applicant.mail_to_reviewer(@membership_application).deliver
        format.html { redirect_to(@membership_application, :notice => 'Your application will be reviewed by our Membership Committee, and you will be contacted soon. Thank you for your interest in aep!') }
        format.xml  { render :xml => @membership_application, :status => :created, :location => @membership_application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @membership_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership_application = MembershipApplication.find(params[:id])
    @membership_application.destroy
    @page = Page.find_by_link("membership")
    
    respond_to do |format|
      format.html { redirect_to(membership_applications_url) }
      format.xml  { head :ok }
    end
  end
end
