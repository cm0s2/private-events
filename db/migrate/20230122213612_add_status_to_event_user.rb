class AddStatusToEventUser < ActiveRecord::Migration[7.0]
  def change
    add_column :event_users, :status, :integer, default: 0
  end
end
