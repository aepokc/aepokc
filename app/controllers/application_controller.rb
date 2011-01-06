class ApplicationController < ActionController::Base
  protect_from_forgery
	layout :by_controller
  
  before_filter :get_tabs
 
  def get_tabs
   	@tabs = Page.find(:all, :conditions => ["parent_id IS NULL", true], :limit => 6, :order => 'position')
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
end
