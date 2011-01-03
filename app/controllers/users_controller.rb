class UsersController < ApplicationController
  before_filter :authenticate_admin!
  
  def index
    @members = Member.order("lastname")
  end

  def show
    @member = Member.find(params[:id])
  end
end
