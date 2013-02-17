class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :member_id
      t.integer :amount
      t.string :token
      t.boolean :paid, :default => false
      t.integer :send_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
