FactoryBot.define do
  factory :item, class: Item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:description) { |n| "Item description #{n}"}
    sequence(:thumbnail) { |n| "thumbnail #{n}"}
    sequence(:price) { |n| rand(1..1000) }
    sequence(:inventory) { |n| rand(1..1000) }
  end
end
