class Applicant < ActionMailer::Base

  def mail_to_reviewer(membership_application)
		@membership_application = membership_application
    mail(:from => "admin@aepokc.com", :to => "acer@micahalcorn.com", :subject => "New member application")
  end
  
end
