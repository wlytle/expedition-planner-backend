class AddPasswordConfirmationToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :passwword_confirmation, :string
  end
end
