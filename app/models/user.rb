class User < ApplicationRecord 
    validates_presence_of :name, :email, :password_digest, :role, :enabled,
                          :address, :city, :zip, :state

    validates_uniqueness_of :email

    enum role: ["default", "merchant", "admin"]

                    
end 