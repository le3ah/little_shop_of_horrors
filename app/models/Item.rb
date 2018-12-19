class Item < ApplicationRecord
  validates_presence_of :name, :description, :thumbnail, :price, :inventory

  validates_inclusion_of :enabled, :in => [true, false]
  has_many :order_items, :dependent => :destroy
  has_many :orders, through: :order_items
  belongs_to :user

  def fulfillment_time
    
  end
end
