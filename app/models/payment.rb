class Payment < ActiveRecord::Base
  belongs_to :member
  
  after_create do |p|
    if p.member.invoices.count && p.amount==p.member.invoices.last.amount
      i = p.member.invoices.last
      i.paid = true
      i.save
    else
      i = Invoice.create(:member_id => p.member.id, :amount => p.amount, :paid => true)
    end
  end
  
  def self.current_count
    payments = Payment.all
    count = 0
    payments.each do |p|
      if !p.expired?
        count+=1
      end
    end
    count
  end
  
  def expired?
    (self.date-Date.today).to_i<-365
  end
end