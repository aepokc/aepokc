class Event < ActiveRecord::Base
	belongs_to :member
	has_and_belongs_to_many :emails
	validates_presence_of :title, :date, :time, :location, :details
	
  has_attached_file :image, :styles => { :display => "200x200>" },
                    :url  => "/assets/images/:id/:style/:basename.:extension",
                    :path => "/home/aepadmin/aepokc/shared/public/assets/images/:id/:style/:basename.:extension"

	def self.find_current
		Event.where(:date => Date.today)
	end
	
	def self.find_past
		Event.find :all, :conditions => ['(date < current_date)'], :order => 'date desc'
	end
	
	def self.find_upcoming
		Event.find :all, :conditions => ['(date > current_date OR date = current_date)'], :order => 'date'
	end
	
	def self.find_feed
		Event.find :all, :conditions => ['sanctioned = true AND (date > current_date OR date = current_date)'], :order => 'date', :limit => 3
	end
end
