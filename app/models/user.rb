class User < ApplicationRecord
    validates_presence_of :name, :email, :password, :role,
                          :address, :city, :zip, :state

    validates_inclusion_of :enabled, :in => [true, false]
    validates_uniqueness_of :email

    enum role: ["default", "merchant", "admin"]

    has_many :orders
    has_many :items
    has_secure_password
end
