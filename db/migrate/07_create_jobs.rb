class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :member_id
      t.string 	:title
      t.string 	:employer
      t.string 	:link
      t.string 	:time
      t.string 	:location
      t.string 	:industry
      t.string 	:experience
      t.string 	:education
      t.integer :salary
      t.text 		:description
      t.string 	:email
      t.string  :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
