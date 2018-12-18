class User < ApplicationRecord
    validates_presence_of :name, :email, :password, :role, :enabled,
                          :address, :city, :zip, :state

    validates_uniqueness_of :email

    enum role: ["default", "merchant", "admin"]

    has_many :orders
    has_many :items
    has_secure_password
end
