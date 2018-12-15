class Order < ApplicationRecord
  validates_presence_of :status

  # belongs_to :user
end
