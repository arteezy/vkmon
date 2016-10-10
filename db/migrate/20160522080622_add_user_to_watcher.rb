class AddUserToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_reference :watchers, :user, foreign_key: true, null: false
  end
end
