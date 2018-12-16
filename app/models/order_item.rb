class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price, :fulfilled

  belongs_to :order
  belongs_to :item
end
