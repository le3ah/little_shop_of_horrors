FactoryBot.define do
  factory :user, class: User do  
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    sequence(:password) { |n| "Password #{n}" }
    sequence(:address) { |n| "Adress #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip) { |n| rand(10000..99999) }
  end
end