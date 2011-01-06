class Members::RegistrationsController < Devise::RegistrationsController
	prepend_before_filter :require_no_authentication, :only => [:show, :new, :create, :cancel]
	prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
	before_filter :authenticate_admin!, :only => [:show, :new, :create, :cancel]
  layout 'admin'
 
  def edit
    render :layout => 'profiles', :scope => 'edit'
  end
	
  def create
    build_resource

    if resource.save
      h = Hominid::API.new('acb09b77fa100d544411e9f4483b92e0-us2')
      h.list_subscribe('2d515044ee', resource.email, [], 'html', false, true, true, false)
      set_flash_message :notice, :signed_up
      redirect_to members_path #remove automatic sign_in upon resource creation
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
  
  def update
    if resource.update_with_password(params[resource_name])      
      set_flash_message :notice, :updated
      redirect_to '/members/profiles'
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end
  
  def destroy
    resource.destroy
    h = Hominid::API.new('acb09b77fa100d544411e9f4483b92e0-us2')
    h.list_unsubscribe('2d515044ee', resource.email, true, false, true)    
    set_flash_message :notice, :destroyed
    sign_out_and_redirect(self.resource)
  end
end