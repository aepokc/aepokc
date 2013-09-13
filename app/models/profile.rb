class Profile < ActiveRecord::Base
	belongs_to :member	
	
	validates_format_of :phone, :with => /[1-9][0-9]{9}/, 
															:message => "- please supply the phone number in the following format: 4058182257",
															:allow_blank => true
	
	has_attached_file :avatar, :styles => { :display => "150x150#", :thumb => "50x50#" },
	                  :url  => "/assets/avatars/:id/:style/:basename.:extension",
	                  :path => "/home/aepadmin/aepokc/shared/public/assets/avatars/:id/:style/:basename.:extension"
	
  def self.get_profile_avatars
    Profile.find :all, :conditions => ('avatar_file_size > 10'), :order => "RAND()"
  end

  def twitter_avatar
  	if self.tname.blank?
  	  return nil
  	else
  	  return Twitter.user(self.tname).profile_image_url
  	end
  end
end