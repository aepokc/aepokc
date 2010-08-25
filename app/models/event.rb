class Event < ActiveRecord::Base
	
	belongs_to :member

	def current_date
		Date.today
	end

	def self.find_past
		Event.find(:all, :conditions => ["date < current_date", true], :order => 'date desc')
	end
	
	def self.find_upcoming
		Event.find(:all, :conditions => ["date > current_date", true], :order => 'date')
	end
	
	def self.find_feed
		Event.find(:all, :conditions => ['sanctioned = "t" AND date > current_date'], :order => 'date', :limit => 3)
	end
	
end
