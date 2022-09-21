class AddPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :login_id, :string
    add_index :users, :login_id, unique: true

    remove_index :users, column: :totp_id
    # remove_column :users, :totp_id, :string
  end
end
