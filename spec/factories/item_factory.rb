require_relative '../../app/models/Item.rb'

FactoryBot.define do
  factory :item, class: Item do
    association :user, factor: :merchant
    sequence(:name) { |n| "Item #{n}" }
    sequence(:description) { |n| "Item description #{n}"}
    sequence(:thumbnail) { |n| "thumbnail #{n}"}
    sequence(:price) { |n| rand(1..1000) }
    sequence(:inventory) { |n| rand(1..1000) }
  end

  factory :disabled_item, parent: :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Inactive Name #{n}"}
    enabled { false }
  end
end
