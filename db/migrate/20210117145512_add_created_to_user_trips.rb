class AddCreatedToUserTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :user_trips, :created, :boolean
  end
end
