class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :sex, null: false
      t.string :nickname
      t.string :domain, null: false
      t.date :bdate
      t.string :city
      t.string :country
      t.string :photo, null: false
      t.boolean :has_mobile
      t.boolean :online, null: false
      t.string :deactivated
      t.string :status
      t.datetime :last_seen
      t.integer :platform
      t.string :university
      t.string :graduation
      t.timestamps
    end
  end
end
