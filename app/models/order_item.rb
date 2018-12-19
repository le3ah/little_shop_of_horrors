class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price
  validates_inclusion_of :fulfilled, in: [true, false]

  belongs_to :order
  belongs_to :item

  def self.avg_fulfillment_time(item)
    joins(items: :order_items)
      .where("order_items.fulfilled = true")
      .where(role: 1)
      .group(item.id)
      .select("avg(order_items.created_at - order_items.updated_at) as avg_f_time")
  end
end
