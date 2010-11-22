class AddBirthdayToMemberAndMembershipApplication < ActiveRecord::Migration
  def self.up
    add_column :members, :birthday, :date
    add_column :membership_applications, :birthday, :date
  end

  def self.down
    remove_column :members, :birthday
    remove_column :membership_applications, :birthday
  end
end
