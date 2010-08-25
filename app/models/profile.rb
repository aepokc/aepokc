class Profile < ActiveRecord::Base

	belongs_to :member	
	
	has_attached_file :avatar, :styles => { :display => "150x150#", :thumb => "50x50#" },
	                  :url  => "/assets/avatars/:id/:style/:basename.:extension",
	                  :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"
	
end
