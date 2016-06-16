class AddFriendsStatusToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :added_friends, :integer, array: true, default: []
    add_column :watchers, :deleted_friends, :integer, array: true, default: []
  end
end
