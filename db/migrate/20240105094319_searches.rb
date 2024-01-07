class Searches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :query, null: false
      t.string :ip_address, null: false
      t.integer :count, default: 0
      
      t.timestamps
    end
  end
end