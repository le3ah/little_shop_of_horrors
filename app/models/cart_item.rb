class CartItem < SimpleDelegator
  attr_reader :quantity

  def initialize(item, quantity=0)
    super(item) 
    @quantity = quantity 
  end
end