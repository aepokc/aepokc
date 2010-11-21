class AddCommitteeToMembershipApplication < ActiveRecord::Migration
  def self.up
    add_column :membership_applications, :committee_name, :string
  end

  def self.down
    remove_column :membership_applications, :committee_name
  end
end
