class User < ApplicationRecord
    validates_presence_of :name, :email, :role,
                          :address, :city, :zip, :state
    validates_presence_of :password, if: :password
    validates :password, confirmation: { case_sensitive: true }
    validates_inclusion_of :enabled, :in => [true, false]
    validates_uniqueness_of :email

  enum role: ["default", "merchant", "admin"]

    has_many :orders
    has_many :items
    has_secure_password

    def self.merchants
      where(role: 1)
    end

    def self.merchants_by_revenue(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(items: :order_items)
        .where("order_items.fulfilled = true")
        .where(role: 1)
        .group(:id)
        .order("revenue #{order}")
        .limit(amount)
        .select("users.*, sum(order_items.price * order_items.quantity) as revenue")
    end

    def self.merchants_by_fullfillment_time(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(items: :order_items)
        .where("order_items.fulfilled = true")
        .where(role: 1)
        .group(:id)
        .order("avg_f_time #{order}")
        .limit(amount)
        .select("users.*, avg(order_items.created_at - order_items.updated_at) as avg_f_time")
    end

    def self.top_states(amount = nil)
      top_cities_or_states(:state, amount)
    end

    def self.top_cities(amount = nil)
      top_cities_or_states(:city, amount)
    end

    def switch_enabled
      self.enabled = !self.enabled
      save
    end

    def self.email_in_use?(email)
      self.where(email: email).any?
    end

    def toggle_role
      self.role = self.role == "default" ? "merchant" : "default"
      save
    end

    def top_5
      Item.joins("INNER JOIN order_items ON order_items.item_id = items.id INNER JOIN orders ON order_items.order_id = orders.id")
      .select("items.*, sum(order_items.quantity) as sum_quantity")
      .group("items.id")
      .order("sum_quantity desc")
      .limit(5)
    end

    def total_sold
      OrderItem.joins(:item, :order)
      .where("status ='complete'")
      .sum(:quantity)
    end

    def total_inventory
      Item.where("user_id = #{self.id}")
      .sum(:inventory)
    end

    def percentage_of_inventory
      ((total_sold.to_f / total_inventory) * 100).round(2)
    end

    def pending_orders
      Order.joins(:items)
      .select("orders.*")
      .where("items.user_id=#{self.id} AND status = 'pending'")
      .group(:id)
    end

    def top_shipment_states
      User.joins("INNER JOIN orders ON orders.user_id = users.id INNER JOIN order_items ON order_items.order_id = orders.id INNER JOIN items ON order_items.item_id = items.id")
      .select("users.state, SUM(order_items.quantity) as order_item_quantity")
      .where("orders.status = 'complete'")
      .where("items.user_id=#{self.id}")
      .group("users.state")
      .order("order_item_quantity desc")
      .limit(3)
    end

    def top_shipment_city_states
      User.joins("INNER JOIN orders ON orders.user_id = users.id INNER JOIN order_items ON order_items.order_id = orders.id INNER JOIN items ON order_items.item_id = items.id")
      .select("users.city, users.state, SUM(order_items.quantity) as order_item_quantity")
      .where("orders.status = 'complete'")
      .where("items.user_id=#{self.id}")
      .group("users.city, users.state")
      .order("order_item_quantity desc")
      .limit(3)
    end

    def most_user_orders
      User.joins("INNER JOIN orders ON orders.user_id = users.id INNER JOIN order_items ON order_items.order_id = orders.id INNER JOIN items ON items.id=order_items.item_id")
      .select("users.*, count(orders.id) as customer_order_quantity")
      .where("items.user_id=#{self.id}")
      .where("order_items.fulfilled=true")
      .group("users.id")
      .order("customer_order_quantity desc")
      .limit(1)
    end

    def most_items_ordered
      User.joins("INNER JOIN orders ON orders.user_id = users.id INNER JOIN order_items ON order_items.order_id = orders.id INNER JOIN items ON items.id=order_items.item_id")
      .select("users.*, sum(order_items.quantity) as customer_order_quantity")
      .where("items.user_id=#{self.id}")
      .where("order_items.fulfilled=true")
      .group("users.id")
      .order("customer_order_quantity desc")
      .limit(1)
    end
    def top_user_spenders
      User.joins("INNER JOIN orders ON orders.user_id = users.id INNER JOIN order_items ON order_items.order_id = orders.id INNER JOIN items ON items.id=order_items.item_id")
      .select("users.*, sum(order_items.quantity * order_items.price) as customer_spend_total")
      .where("items.user_id=#{self.id}")
      .where("order_items.fulfilled=true")
      .group("users.id")
      .order("customer_spend_total desc")
      .limit(3)
    end
    private

    def self.top_cities_or_states(city_or_state, amount)
      if city_or_state == :city
        group = [:city, :state]
        selection = "city, state"
        order = "city asc, state asc"
      else
        group = :state
        selection = "state"
        order = "state asc"
      end

      select("#{selection}, count(orders.id) as order_count")
        .joins(:orders)
        .where("orders.status = ?", :complete)
        .group(group)
        .order("order_count desc, #{order}")
        .limit(amount)
    end

    def self.default
      User.where(role: "default")
    end
end
