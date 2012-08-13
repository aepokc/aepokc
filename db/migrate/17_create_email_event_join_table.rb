class CreateEmailEventJoinTable < ActiveRecord::Migration
  def self.up
    create_table :emails_events, :id => false do |t|
      t.integer :email_id
      t.integer :event_id
    end
  end

  def self.down
    drop_table :emails_events
  end
end
