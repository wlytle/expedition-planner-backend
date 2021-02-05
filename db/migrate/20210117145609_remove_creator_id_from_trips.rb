class RemoveCreatorIdFromTrips < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :creator_id
  end
end
