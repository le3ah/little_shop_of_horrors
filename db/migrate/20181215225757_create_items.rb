class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :thumbnail
      t.integer :price
      t.integer :inventory
      t.boolean :enabled, default: true, null: false

      t.timestamps
    end
  end
end
