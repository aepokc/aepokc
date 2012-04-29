class Applicant < ActionMailer::Base
  def mail_to_reviewer(membership_application)
		@membership_application = membership_application
		string = @membership_application.firstname + @membership_application.lastname + @membership_application.email + @membership_application.created_at.to_s
		token = Digest::MD5.hexdigest(string)
		@url = 'http://aepokc.com/approve?token='+token
    mail(:from => "applicant@aepokc.com", :to => "membership@aepokc.com", :subject => "New member application")
  end
end
