class Page < ActiveRecord::Base
	has_many :subpages, :class_name => 'Page', :foreign_key => 'parent_id'
	belongs_to :parent, :class_name => 'Page', :foreign_key => 'parent_id'
	validates_presence_of :title, :link, :position
	validates_uniqueness_of :title, :link, :position
	
	def self.find_parents
		Page.find(:all, :conditions => ["parent_id IS NULL", true], :order => 'position')
	end
	
	def self.find_subpages
		Page.find(:all, :conditions => {:parent_id => true}, :order => 'position')
	end
end