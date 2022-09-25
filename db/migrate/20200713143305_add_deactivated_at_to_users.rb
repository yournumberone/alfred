class AddDeactivatedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deactivated_at, :timestamp
  end
end
