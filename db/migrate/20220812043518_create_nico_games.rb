class CreateNicoGames < ActiveRecord::Migration[7.0]
  def change
    create_table :nico_games do |t|
      t.integer :user_id
      t.text :videos

      t.timestamps
    end
  end
end
