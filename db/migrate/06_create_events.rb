class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :member_id
      t.string	:title
      t.date 		:date
      t.string 	:time
      t.text 		:details
      t.boolean	:sanctioned

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
