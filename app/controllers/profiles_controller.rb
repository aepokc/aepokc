class ProfilesController < ApplicationController
	
	before_filter :authenticate_member!
  before_filter :verify_changed_password  
  
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

    respond_to do |format|
      format.html
      format.xml  { render :xml => @profiles }
    end
  end	
	
  def index
    @profiles = Profile.get_profile_avatars
  end

  def show
  	if current_member.profile.blank?
  		respond_to do |format|
  			format.html { redirect_to(new_members_profile_path, :notice => 'You still need to tell us about yourself.') }
			end
  	else
		  @profile = Profile.find(params[:id])

		  respond_to do |format|
		    format.html
		    format.xml  { render :xml => @profile }
		  end
		end
  end

  def new
  	if current_member.profile.blank?
		  @profile = Profile.new

		  respond_to do |format|
		    format.html
		    format.xml  { render :xml => @profile }
		  end
		else
			respond_to do |format|
				format.html { redirect_to(members_profiles_path, :notice => 'You have already created a profile.') }
			end
		end
  end

  def edit
  	if current_member.profile.nil?
  		respond_to do |format|
  			format.html { redirect_to(new_members_profile_path, :notice => 'Here you can create your member profile.') }
			end
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

  def create
  	if current_member.profile.nil?
		  @profile = Profile.new(params[:profile])

		  respond_to do |format|
		    if @profile.save
		      format.html { redirect_to([:members, @profile], :notice => 'Profile was successfully created.') }
		      format.xml  { render :xml => @profile, :status => :created, :location => @profile }
		    else
		      format.html { render :action => "new" }
		      format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
		    end
		  end
		else
			respond_to do |format|
				format.html { redirect_to('/members/profiles/' + current_member.profile.id.to_s, :notice => 'You have already created a profile.') }
			end
		end
  end

  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to([:members, @profile], :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(members_profiles_url) }
      format.xml  { head :ok }
    end
  end
end
