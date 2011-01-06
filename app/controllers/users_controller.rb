class UsersController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'
  
  def index
    @members = Member.order("lastname")
  end

  def show
    @member = Member.find(params[:id])
  end
  
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    h = Hominid::API.new('acb09b77fa100d544411e9f4483b92e0-us2')
    h.list_unsubscribe('2d515044ee', @member.email, true, false, true)    
    redirect_to(members_url)
  end
end
