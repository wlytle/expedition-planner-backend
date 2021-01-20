class AddStartDateAndEndDateToLegs < ActiveRecord::Migration[6.0]
  def change
    add_column :legs, :start_date, :datetime
    add_column :legs, :end_date, :datetime
  end
end
