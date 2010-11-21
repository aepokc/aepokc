class MembershipApplication < ActiveRecord::Base

	validates_presence_of :firstname, :lastname, :email, :address, :city, :state, :zip, :phone, 
												:company, :title, :associations, :interests, :committee_name, :agreement
	validates_uniqueness_of :email
 
end
