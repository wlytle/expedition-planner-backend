class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.boolean :completed
      t.text :notes
      t.references :creator_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
