class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :member_id
      t.integer :amount
      t.string	:source
      t.date		:date

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
