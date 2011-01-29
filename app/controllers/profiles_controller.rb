class ProfilesController < ApplicationController
  
  before_filter :authenticate_someone
  
  def authenticate_someone
    if admin_signed_in?
      warden.authenticate!(:scope => :admin)
    else
      warden.authenticate!(:scope => :member)
      :verify_changed_password 
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
	
	layout 'profiles'
	
  def directory    
    @members = Member.paginate :page=>params[:page], :order=>'lastname', :per_page => 10    
  end	
	
  def index
    @profiles = Profile.all
  end

  def show
    if admin_signed_in?
      @profile = Profile.find(params[:id])
    else
      if current_member.profile.blank?
        redirect_to(new_members_profile_path, :notice => 'You still need to tell us about yourself.')       
      else
        @profile = Profile.find(params[:id])
      end
    end
  end

  def new
  	if current_member.profile.blank?
      @profile = Profile.new
    else      
      redirect_to(members_profiles_path, :notice => 'You have already created a profile.')      
		end
  end

  def edit
    if admin_signed_in?
      @profile = Profile.find(params[:id])
    else
      if current_member.profile.nil?        
        redirect_to(new_members_profile_path, :notice => 'Here you can create your member profile.')         
      else
        @profile = Profile.find(params[:id])
  			if @profile.member.nil?
          redirect_to "/members/profiles/directory", :notice => 'Members can only edit their own profile.'
        else
  				if @profile.member.id == current_member.id
            render :view => "edit"
          else
            redirect_to "/members/profiles/directory", :notice => 'Members can only edit their own profile.'
          end
        end
      end
    end
  end

  def create
  	if current_member.profile.nil?
		  @profile = Profile.new(params[:profile])
      if @profile.save
		    redirect_to([:members, @profile], :notice => 'Profile was successfully created.')
      else
        render :action => "new"        
		  end
		else
      redirect_to('/members/profiles/' + current_member.profile.id.to_s, :notice => 'You have already created a profile.')      
		end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      redirect_to([:members, @profile], :notice => 'Profile was successfully updated.')      
    else
      render :action => "edit"      
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to(members_profiles_url)
  end
end