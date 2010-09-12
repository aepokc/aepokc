class AddRandomPasswords < ActiveRecord::Migration
  def self.up
  	add_column :members, :random_password, :string
  end

  def self.down
  	remove_column :members, :random_password
  end
end
