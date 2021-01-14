class CreateUserTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :user_trips do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :accepted
      t.text :notes

      t.timestamps
    end
  end
end
