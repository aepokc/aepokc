class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.datetime :sent_at
      t.string :title
      t.string :from_name
      t.string :reply_to
      t.string :subject_line
      t.string :recipients
      t.text :preface
      t.text :html

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
