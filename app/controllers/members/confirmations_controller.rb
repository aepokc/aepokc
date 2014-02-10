class Members::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      resource.active = true
      resource.save
      set_flash_message :notice, :confirmed
      sign_in(resource_name, resource) #change redirect from edit to profiles index
      redirect_to stored_location_for(:member) || members_profiles_path
    else
      render_with_scope :new
    end
  end
end