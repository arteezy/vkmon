class CreateWatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :watchers do |t|
      t.integer :vk_id, null: false
      t.string :name, null: false
      t.string :photo, null: false
      t.string :domain, null: false
      t.datetime :last_seen, null: false

      t.timestamps null: false
    end
  end
end
