class CreateMembershipApplications < ActiveRecord::Migration
  def self.up
    create_table :membership_applications do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :company
      t.string :title
      t.text :associations
      t.text :interests
      t.string :first
      t.string :second
      t.string :third
      t.boolean :agreement

      t.timestamps
    end
  end

  def self.down
    drop_table :membership_applications
  end
end
