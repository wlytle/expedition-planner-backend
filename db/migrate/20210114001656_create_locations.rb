class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.float :ele
      t.references :leg, null: false, foreign_key: true

      t.timestamps
    end
  end
end
