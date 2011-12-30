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
    @member.unsubscribe
    @member.destroy   
    redirect_to(members_url)
  end
end