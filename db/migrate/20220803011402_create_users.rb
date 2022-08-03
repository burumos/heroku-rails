class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :totp_key

      t.timestamps
    end
    add_index :users, :totp_key, unique: true
  end
end
