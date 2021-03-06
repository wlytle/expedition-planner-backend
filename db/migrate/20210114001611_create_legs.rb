class CreateLegs < ActiveRecord::Migration[6.0]
  def change
    create_table :legs do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :user_trip, null: false, foreign_key: true
      t.string :sport
      t.float :distance
      t.float :aeg
      t.text :notes

      t.timestamps
    end
  end
end
