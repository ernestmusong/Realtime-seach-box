class Articles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.text :title

      t.timestamps
    end
  end
end