class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
    	t.integer		:member_id
      t.string 		:avatar_file_name
      t.string 		:avatar_content_type
      t.integer 	:avatar_file_size
      t.datetime 	:avatar_updated_at
      t.string		:phone
      t.string 		:email
      t.string 		:hometown
      t.string 		:college
      t.string 		:degree
      t.string 		:occupation
      t.text 			:interests
      t.string 		:status
      t.string 		:fname
      t.string 		:tname
      t.string 		:lname

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
