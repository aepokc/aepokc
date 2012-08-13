class EmailsController < ApplicationController
  before_filter :authenticate_admin!, except: [:show]
  layout 'admin'

  def index
    @emails = Email.order("sent_at desc", "created_at desc")
  end

  def show
    @email = Email.find(params[:id])
    @events = @email.events.order("date asc")
    render layout: false
  end

  def new
    @email = Email.new
    @events = Event.all.reverse
  end

  def edit
    @email = Email.find(params[:id])
    @events = Event.all.reverse
  end

  def create
    @email = Email.new(params[:email])
    if params[:email][:events]
      @email.parse_events(params[:email][:events])
    end
    if @email.save
      redirect_to edit_email_path(@email), :notice => 'Email was successfully drafted.'
    else
      render :action => "new"
    end
  end

  def update
    @email = Email.find(params[:id])
    if params[:email][:events]
      @email.parse_events(params[:email][:events])
    end
    if @email.update_attributes(params[:email])
      if params[:email][:sendable]=='true'
        begin
          @email.send_from_mailchimp
        rescue
          redirect_to edit_email_path(@email), :notice => 'A problem has occurred with MailChimp.'
        end
        @email.sent_at = Time.now
        @email.save
        redirect_to emails_path, :notice => 'Email sent successfully.'
      else
        redirect_to edit_email_path(@email), :notice => 'Email was successfully updated.'
      end
    else
      render :action => "edit"
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to(emails_url)
  end
end
