class CreateFriendsWatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :friends_watchers, id: false do |t|
      t.belongs_to :friend, index: true
      t.belongs_to :watcher, index: true
    end
  end
end
