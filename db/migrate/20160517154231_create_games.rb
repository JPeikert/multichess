class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :room, index: true, foreign_key: true

      t.timestamps
    end
  end
end
