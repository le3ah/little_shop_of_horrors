class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|

      t.integer :quantity
      t.integer :price
      t.boolean :fulfilled, default: false

      t.timestamps
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
