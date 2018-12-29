class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  def self.top_by_quantity(amount = nil)
    joins(:order_items)
      .select("sum(order_items.quantity) as total_quantity")
      .where(status: "complete")
      .group(:id)
      .order("total_quantity desc")
      .limit(amount)
  end

  def self.any_complete?
    where(status: "complete").count > 0
  end

  def self.cancel(order_id)
    order = self.find(order_id)
    order.status = "cancelled"
    order.save
    OrderItem.return_inventory_for(order.id)
    OrderItem.unfulfill_items_for(order.id)
  end

  def quantity_of_order
    order_items.pluck("sum(quantity)")[0]
  end

  def quantity_of_my_items(user_id)
    OrderItem.joins(:item)
    .where("order_id=? AND items.user_id=?", self.id, user_id)
    .pluck("sum(quantity)")[0]
  end

  def grand_total
    order_items.pluck("sum(quantity * price)")[0]
  end

  def value_of_my_items(user_id)
    OrderItem.joins(:item)
    .where("order_id=? AND items.user_id=?", self.id, user_id)
    .pluck("sum(quantity * order_items.price)")[0]
  end

  def order_items_for_merchant(merchant_id)
    OrderItem.joins(:item)
      .select("order_items.*, items.*")
      .where("order_id=? AND items.user_id=?", self.id, merchant_id)
  end
end
