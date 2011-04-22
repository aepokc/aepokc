class Resources::JobsController < ApplicationController
  before_filter :verify_changed_password  
  
	def verify_changed_password
		if member_signed_in?
			unless current_member.random_password == 'replaced'
				redirect_to '/members/edit', :notice => 'You must replace your temporary password before proceeding.'
			end
		else
		end
	end
	
	before_filter :authenticate_member!

	layout 'resources'
	
  def index
    @jobs = Job.find_fresh
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
    if @job.member.nil?
    	redirect_to "/resources/jobs", :notice => 'Members can only edit their own jobs.'
    else
		  if @job.member.id == current_member.id
		  	render :view => "edit"
		  else
		  	redirect_to "/resources/jobs", :notice => 'Members can only edit their own jobs.'
		  end
		end
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      @job.expiration = @job.updated_at+14.days
      @job.save
      redirect_to([:resources, @job], :notice => 'Job was successfully created.')
    else
      redirect_to(new_resources_job_path, :notice => @job.errors)
    end
  end

  def update
    @job = Job.find(params[:id])
    
    if @job.update_attributes(params[:job])
      @job.expiration = @job.updated_at+14.days
      @job.save
      redirect_to([:resources, @job], :notice => 'Job was successfully updated.')
    else
      render :action => "edit", :notice => @job.errors
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    format.html { redirect_to(resources_jobs_url)
  end
end