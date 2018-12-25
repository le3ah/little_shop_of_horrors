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
        .order("item_count #{order}")
        .limit(amount)
        .select("items.*, sum(quantity) as item_count")
  end

  def self.return_inventory(items_and_quantities)
    items_and_quantities.each do |i_q|
      item = self.where(id: i_q.first).first
      item.update(inventory: item.inventory + i_q.last)
    end
  end
end
