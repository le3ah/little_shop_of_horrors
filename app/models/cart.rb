class Cart
  attr_reader :data
  def initialize(input_data = nil)
    @data = input_data || Hash.new
  end

  def items
    @data.map do |item_id, quantity|
      item = Item.find(item_id)
      CartItem.new(item, quantity)
    end
  end

  def items_quantity
    @data.inject(0){ |acc, (_id, quantity)| acc += quantity }
  end

  def add_item(item)
    data[item.id.to_s] ||= 0
    data[item.id.to_s] += 1
  end

  def update_item(item_id, adding)
    if adding
      return false unless enough_inventory_for_more?(item_id)
      data[item_id.to_s] += 1
    else
      data[item_id.to_s] -= 1
      @data.delete(item_id.to_s) if data[item_id.to_s] == 0
      return true
    end
  end

  def grand_total
    items.inject(0) do |total, item|
      total += item.price * item.quantity
    end
  end

  def enough_inventory_for_more?(item_id)
    data[item_id.to_s] < Item.find(item_id).inventory
  end

  def clear
    @data = Hash.new
  end
end
