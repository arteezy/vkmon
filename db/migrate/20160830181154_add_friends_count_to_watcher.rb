class AddFriendsCountToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :friends_count, :integer, default: 0, null: false
  end
end
