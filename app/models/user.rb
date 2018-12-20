class User < ApplicationRecord
    validates_presence_of :name, :email, :role,
                          :address, :city, :zip, :state
    validates_presence_of :password, if: :password
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

    def self.merchants_by_fullfillment(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(items: :order_items)
        .where("order_items.fulfilled = true")
        .where(role: 1)
        .group(:id)
        .order("avg_f_time #{order}")
        .limit(amount)
        .select("users.name, avg(order_items.created_at - order_items.updated_at) as avg_f_time")
    end

    def switch_enabled
      switch_boolean = !attributes["enabled"]
      update(enabled: switch_boolean)
    end

    def self.default
      User.where(role: "default")    
    end 
end
