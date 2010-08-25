class Members::SessionsController < Devise::SessionsController

  def new
    clean_up_passwords(build_resource)
    render_with_scope :new
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "new")
    set_flash_message :notice, :signed_in
    sign_in(resource_name, resource) #change redirect from edit to profiles index
    redirect_to members_profiles_path
  end

  def destroy
    set_flash_message :notice, :signed_out if signed_in?(resource_name)
    sign_out(resource_name) #change redirect from edit to profiles index
    redirect_to members_profiles_path
  end

end
