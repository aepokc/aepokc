class Profile < ActiveRecord::Base

	belongs_to :member	
	
	validates_format_of :phone, :with => /[1-9][0-9]{9}/, 
															:message => "- please supply the phone number in the following format: 4058182257",
															:allow_blank => true
	
	has_attached_file :avatar, :styles => { :display => "150x150#", :thumb => "50x50#" },
	                  :url  => "/assets/avatars/:id/:style/:basename.:extension",
	                  :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"
	
end
