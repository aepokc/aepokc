class Receipt < ActionMailer::Base
  
  def mail_to_payer(payment)
		@payment = payment
    mail(:from => "admin@aepokc.com", :to => payment.member.email, :subject => "aep | Membership Dues Receipt")
  end
end