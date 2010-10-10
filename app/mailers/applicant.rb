class Applicant < ActionMailer::Base

  def mail_to_reviewer(membership_application)
		@membership_application = membership_application
    mail(:from => "applicant@aepokc.com", :to => "admin@aepokc.com", :subject => "New member application")
  end
  
end
