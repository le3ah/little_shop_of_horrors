class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price
  validates_inclusion_of :fulfilled, in: [true, false]

  belongs_to :order
  belongs_to :item

  def self.checkout_cart(cart, order_id)
    cart.data.each do |c_i|
      item = Item.find(c_i.first)
      create(
        quantity: c_i.last,
        price: item.price,
        order_id: order_id,
        item_id: item.id
      )
    end
  end

  def self.unfulfill_items_for(order_id)
    where(order_id: order_id).update_all(fulfilled: false, updated_at: Time.now)
  end

  def self.return_inventory_for(order_id)
    items_and_quantities = self
      .where(order_id: order_id, fulfilled: true)
      .pluck(:item_id, :quantity)
    Item.return_inventory(items_and_quantities)
  end

  def self.avg_fulfillment_time(item)
    where(fulfilled: true)
      .where(item_id: item.id)
      .average("updated_at - created_at")
  end

  def subtotal
    quantity * price
  end
end
