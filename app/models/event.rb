class Event < ActiveRecord::Base
	
	belongs_to :member

	def current_date
		Date.today
	end

	def self.find_current
		Event.where(:date => Date.today)
	end
	
	def self.find_past
		Event.find :all, :conditions => ['(date < current_date)'], :order => 'date desc'
	end
	
	def self.find_upcoming
		Event.find :all, :conditions => ['(date > current_date)'], :order => 'date'
	end
	
	def self.find_feed
		Event.find :all, :conditions => ['sanctioned = true AND (date > current_date OR date = current_date-1)'], :order => 'date', :limit => 3
	end
	
end
