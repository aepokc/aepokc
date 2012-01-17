class MembershipApplication < ActiveRecord::Base
	validates_presence_of :firstname, :lastname, :email, :address, :city, :state, :zip, :phone, 
												:company, :title, :committee_name, :agreement
	validates_uniqueness_of :email

  def create_member
    m = Member.new
    m.leader = false
    m.email = self.email
    m.firstname = self.firstname
    m.lastname = self.lastname
    m.committee_name = self.committee_name
    m.birthday = self.birthday
    m.save
    if m.errors
      return m.errors
    else
      m.subscribe
      return true
    end
  end
end