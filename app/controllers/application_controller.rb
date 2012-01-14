class ApplicationController < ActionController::Base
  protect_from_forgery
	layout :by_controller
  
  before_filter :get_tabs
 
  def get_tabs
   	@tabs = Page.find(:all, :conditions => ["parent_id IS NULL", true], :limit => 6, :order => 'position')
  end
  
  def authenticate_someone
    if admin_signed_in?
      warden.authenticate!(:scope => :admin)
    else
      warden.authenticate!(:scope => :member)
      :verify_changed_password 
    end
  end
  
  def by_controller
    if devise_controller? 
   		if resource_name == :member
     		"profiles"
      else
      	"admin"
      end
    else
	   	"application"
    end
  end
  
  def require_signed_out
    if member_signed_in?
      redirect_to '/members/profiles', :notice => 'Please logout before signing in to the Admin account.'
    elsif admin_signed_in?
      redirect_to '/admin', :notice => 'Please logout of Admin before signing in to a member account.'
    end
  end
  
  def verify_changed_password
    if member_signed_in?
      unless current_member.random_password == 'replaced'
        redirect_to '/members/edit', :notice => 'You must replace your temporary password before proceeding.'
      end
    else
    end
  end
end