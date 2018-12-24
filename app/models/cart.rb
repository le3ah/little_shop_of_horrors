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

  def add_item(item)
    data[item.id.to_s] ||= 0
    data[item.id.to_s] += 1
  end

  def update_item(item, adding)
    item_id = item.id.to_s
    if adding
      data[item_id] += 1
    else
      data[item_id] -= 1
      @data.delete(item_id) if data[item_id] == 0
    end
  end
end
