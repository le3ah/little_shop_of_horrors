class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price
  validates_inclusion_of :fulfilled, in: [true, false]

  belongs_to :order
  belongs_to :item

  def self.avg_fulfillment_time(item)
    where(fulfilled: true)
      .where(item_id: item.id)
      .average("updated_at - created_at")
  end

  def subtotal
    quantity * price
  end

end
