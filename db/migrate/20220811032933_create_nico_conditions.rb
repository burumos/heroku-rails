class CreateNicoConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :nico_conditions do |t|
      t.integer :user_id
      t.string :query
      t.integer :limit
      t.integer :minimum_views

      t.timestamps
    end
  end
end
