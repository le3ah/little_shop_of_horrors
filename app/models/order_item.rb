class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price
  validates_inclusion_of :fulfilled, in: [true, false]
  
  belongs_to :order
  belongs_to :item
end
