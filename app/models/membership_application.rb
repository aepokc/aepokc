class MembershipApplication < ActiveRecord::Base

	validates_presence_of :firstname, :lastname, :email, :address, :city, :state, :zip, :phone, 
												:company, :title, :associations, :interests, :first, :second, :third, :agreement
	validates_uniqueness_of :email
 
end
