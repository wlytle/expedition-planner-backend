class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.boolean :completed
      t.text :notes
      t.integer :creator_id

      t.timestamps
    end
  end
end
