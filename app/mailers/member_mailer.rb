class MemberMailer < ActionMailer::Base
  def send_invoice(invoice)
    @invoice = invoice
    @member = @invoice.member
    mail(:from => "aep Admin <admin@aepokc.com>", :to => @member.email, :subject => "aep | Membership Dues Invoice")
  end
  
  def send_receipt(payment)
		@payment = payment
    mail(:from => "aep Admin <admin@aepokc.com>", :to => payment.member.email, :subject => "aep | Membership Dues Receipt")
  end
  
  def send_confirmation(member)
    @member = member
    mail(:from => "aep Admin <admin@aepokc.com>", :to => @member.email, :subject => "aep | Account Confirmation")
  end
end