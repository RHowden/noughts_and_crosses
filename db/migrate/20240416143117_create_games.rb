class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :board, null: false
      t.string :current_player, null: false

      t.timestamps
    end
  end
end
