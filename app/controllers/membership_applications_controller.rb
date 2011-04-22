class MembershipApplicationsController < ApplicationController

	layout 'applicants'
	before_filter :authenticate_admin!, :only => [:index, :show]

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
    @contact = Page.find_by_link("contact")
    
    if @membership_application.save
      Applicant.mail_to_reviewer(@membership_application).deliver
      redirect_to(@contact, :notice => 'Submitted successfully. Your application will be reviewed by our Membership Committee, and you will be contacted soon. Thank you for your interest in aep!')
    else
      render :action => "new"
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