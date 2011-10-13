class Payment < ActiveRecord::Base
  belongs_to :member
  
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