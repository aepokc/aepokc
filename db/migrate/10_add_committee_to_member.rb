class AddCommitteeToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :committee_name, :string
  end

  def self.down
    remove_column :members, :committee_name
  end
end
