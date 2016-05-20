class AddPlayersToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :player1, :integer
    add_column :rooms, :player2, :integer
  end
end
