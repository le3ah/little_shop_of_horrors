FactoryBot.define do
  factory :order do
    user
    status  { "pending" }
  end
  factory :completed_order, parent: :order do
    user
    status  { "complete" }
  end
  factory :cancelled_order, parent: :order do
    user
    status  { "cancelled" }
  end
end
