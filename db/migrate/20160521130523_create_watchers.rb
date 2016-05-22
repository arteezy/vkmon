class CreateWatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :watchers do |t|
      t.integer :vk_id
      t.string :name
      t.string :photo

      t.timestamps null: false
    end
  end
end
