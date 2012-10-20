class MembershipApplicationsController < ApplicationController
	layout 'applicants'
	before_filter :authenticate_admin!, :only => [:index, :show, :approve]

  def index
    @membership_applications = MembershipApplication.all(:order => 'id DESC')
    @page = Page.find_by_link("membership")
    render :layout => 'admin'
  end

  def show
    @membership_application = MembershipApplication.find(params[:id])
    @page = Page.find_by_link("membership")
  end

  def new
    @membership_application = MembershipApplication.new
    @page = Page.find_by_link("membership")
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
  
  def approve
    if params[:token]
      success = nil
      applicants = MembershipApplication.find(:all, :limit => 20, :order => "id DESC")
      applicants.each do |a|
        string = a.firstname + a.lastname + a.email + a.created_at.to_s
        if Digest::MD5.hexdigest(string)==params[:token]
          success = a.create_member
        end
      end
      if success && success==true
        redirect_to members_path, :notice => 'Applicant converted to member.'
      elsif success
        redirect_to members_path, :notice => success
      else
        redirect_to members_path, :notice => 'Applicant has expired.'
      end
    else
      redirect_to admin_path, :notice => 'Token missing.'
    end
  end

  def destroy
    @membership_application = MembershipApplication.find(params[:id])
    @membership_application.destroy
    @page = Page.find_by_link("membership")
    
    redirect_to(membership_applications_url)
  end
end