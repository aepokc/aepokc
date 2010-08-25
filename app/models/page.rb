class Page < ActiveRecord::Base

	has_many :subpages, :class_name => 'Page', :foreign_key => 'parent_id'
	belongs_to :parent, :class_name => 'Page', :foreign_key => 'parent_id'
	
	def self.find_parents
		Page.find(:all, :conditions => ["parent_id IS NULL", true], :order => 'position')
	end
	
	def self.find_subpages
		Page.find(:all, :conditions => {:parent_id => true}, :order => 'position')
	end
	
end
