class Item < ApplicationRecord
  validates_presence_of :name, :description, :thumbnail, :price, :inventory, :enabled

  has_many :order_items, :dependent => :destroy
  has_many :orders, through: :order_items
end
