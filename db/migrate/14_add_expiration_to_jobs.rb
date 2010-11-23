class AddExpirationToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :expiration, :date
  end

  def self.down
    remove_column :jobs, :expiration
  end
end
