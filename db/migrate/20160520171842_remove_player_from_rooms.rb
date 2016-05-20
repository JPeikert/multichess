class RemovePlayerFromRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :player, :string
  end
end
