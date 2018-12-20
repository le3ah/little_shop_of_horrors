class Item < ApplicationRecord
  validates_presence_of :name, :description, :thumbnail, :price, :inventory

  validates_inclusion_of :enabled, :in => [true, false]
  has_many :order_items, :dependent => :destroy
  has_many :orders, through: :order_items
  belongs_to :user

  def self.popular_items(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(:order_items)
        .where("order_items.fulfilled = true")
        .group(:id)
        .order("quantity #{order}")
        .limit(amount)
  end

end
