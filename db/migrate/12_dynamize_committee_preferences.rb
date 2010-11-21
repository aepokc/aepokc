class DynamizeCommitteePreferences < ActiveRecord::Migration
  def self.up
  	Committee.create(:name => "Volunteer")
  	Committee.create(:name => "Social")
  	Committee.create(:name => "Membership")
  	Committee.create(:name => "Marketing")
  	Committee.create(:name => "Internal Affairs")
  	
  	MembershipApplication.all.each do |c|
  		c.committee_name = c.first
  		c.save
  	end
  	
  	remove_column :membership_applications, :first
  	remove_column :membership_applications, :second
  	remove_column :membership_applications, :third  
  end

  def self.down
  	Committee.destroy_all
  	
  	add_column :membership_applications, :first, :string
  	add_column :membership_applications, :second, :string
  	add_column :membership_applications, :third, :string
  end
end
