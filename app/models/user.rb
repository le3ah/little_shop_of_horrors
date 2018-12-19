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

    def switch_enabled
      switch_boolean = !attributes["enabled"]
      update(enabled: switch_boolean)
    end 

end
